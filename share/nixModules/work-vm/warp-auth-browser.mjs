import { readFileSync } from "node:fs";
import { appendFile, chmod, mkdir, rename, writeFile } from "node:fs/promises";
import { isIPv4 } from "node:net";
import process from "node:process";

function parseArguments(argv) {
  const values = new Map();
  for (let index = 0; index < argv.length; index += 2) {
    const name = argv[index];
    const value = argv[index + 1];
    if (!name?.startsWith("--") || value === undefined) {
      throw new Error("Expected --name value arguments");
    }
    values.set(name.slice(2), value);
  }
  return values;
}

function requireValue(values, name) {
  const value = values.get(name);
  if (value === undefined || value.length === 0) {
    throw new Error("Missing --" + name);
  }
  return value;
}

function publicUrl(value) {
  try {
    const url = new URL(value);
    return url.origin;
  } catch {
    return "<invalid-url>";
  }
}

function boundedText(value, limit = 2000) {
  const text = String(value)
    .replaceAll(/https?:\/\/[^\s"'<>]+/gu, (match) => publicUrl(match))
    .replaceAll(
      /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/giu,
      "<redacted-email>",
    )
    .replaceAll(/\b[A-Za-z0-9_-]{48,}\b/gu, "<redacted-opaque-value>");
  return text.length <= limit ? text : text.slice(0, limit) + "…";
}

function publicRemoteAddress(value) {
  if (value === null || value === undefined) return null;
  return {
    ipAddress: value.ipAddress,
    port: value.port,
  };
}

const values = parseArguments(process.argv.slice(2));
const authUrlInput = readFileSync(0, "utf8").trim();
if (authUrlInput.length === 0) {
  throw new Error("Missing authentication URL on stdin");
}
const authUrl = new URL(authUrlInput);
const authAddress = requireValue(values, "auth-address");
const profileDirectory = requireValue(values, "profile-directory");
const runDirectory = requireValue(values, "run-directory");
const playwrightModule = requireValue(values, "playwright-module");
const chromiumExecutable = requireValue(values, "chromium-executable");

if (
  authUrl.protocol !== "https:" ||
  authUrl.username.length !== 0 ||
  authUrl.password.length !== 0 ||
  !isIPv4(authAddress)
) {
  throw new Error(
    "The authentication target must be a credential-free HTTPS URL with a resolved IPv4 address",
  );
}

await mkdir(profileDirectory, { recursive: true, mode: 0o700 });
await mkdir(runDirectory, { recursive: true, mode: 0o700 });

const eventsPath = runDirectory + "/events.jsonl";
const statusPath = runDirectory + "/status.json";
const readyPath = runDirectory + "/ready.json";
let eventChain = Promise.resolve();
let statusChain = Promise.resolve();
let closing = false;

function record(type, details = {}) {
  const event = {
    schema: "work-vm-warp-browser-event/v1",
    timestamp: new Date().toISOString(),
    type,
    details,
  };
  eventChain = eventChain.then(() =>
    appendFile(eventsPath, JSON.stringify(event) + "\n", { mode: 0o600 }),
  );
  return eventChain;
}

async function writeJsonAtomic(path, value) {
  const temporaryPath = path + ".tmp";
  await writeFile(temporaryPath, JSON.stringify(value, null, 2) + "\n", {
    mode: 0o600,
  });
  await rename(temporaryPath, path);
  await chmod(path, 0o600);
}

async function updateStatus(phase, details = {}) {
  if (closing) return;
  statusChain = statusChain.then(() =>
    writeJsonAtomic(statusPath, {
      schema: "work-vm-warp-browser-status/v1",
      updatedUtc: new Date().toISOString(),
      phase,
      pid: process.pid,
      details,
    }),
  );
  await statusChain;
}

async function finishStartup(status, details = {}) {
  const result = {
    schema: "work-vm-warp-browser-ready/v1",
    readyUtc: new Date().toISOString(),
    status,
    pid: process.pid,
    details,
  };
  await writeJsonAtomic(readyPath, result);
  await updateStatus(status, details);
}

await record("harness_started", {
  target: publicUrl(authUrl.href),
  pid: process.pid,
});
await updateStatus("launching");

let context;
let traceStarted = false;

async function closeHarness(reason) {
  if (closing) return;
  closing = true;
  await record("harness_stopping", { reason });
  if (context !== undefined) {
    if (traceStarted) {
      try {
        await context.tracing.stop({ path: runDirectory + "/trace.zip" });
      } catch (error) {
        await record("trace_stop_failed", {
          message: boundedText(error instanceof Error ? error.message : error),
        });
      }
    }
    await context.close().catch(() => {});
  }
  await statusChain.catch(() => {});
  await eventChain;
}

process.on("SIGTERM", () => {
  void closeHarness("SIGTERM").finally(() => process.exit(0));
});
process.on("SIGINT", () => {
  void closeHarness("SIGINT").finally(() => process.exit(0));
});

try {
  const { chromium } = await import(playwrightModule);
  context = await chromium.launchPersistentContext(profileDirectory, {
    executablePath: chromiumExecutable,
    headless: false,
    viewport: null,
    acceptDownloads: false,
    args: [
      "--disable-quic",
      "--host-resolver-rules=MAP " +
        authUrl.hostname +
        " " +
        authAddress +
        ", EXCLUDE localhost",
      "--no-default-browser-check",
      "--no-first-run",
    ],
  });

  if (process.env.WORK_VM_WARP_AUTH_TRACE === "1") {
    await context.tracing.start({ screenshots: true, snapshots: true });
    traceStarted = true;
    await record("trace_started", { sensitivity: "private-authentication-state" });
  }

  const instrumentedPages = new WeakSet();
  async function instrumentPage(page) {
    if (instrumentedPages.has(page)) return;
    instrumentedPages.add(page);

    page.on("console", (message) => {
      const details = {
        level: message.type(),
        source: publicUrl(message.location().url || ""),
      };
      if (process.env.WORK_VM_WARP_AUTH_TRACE === "1") {
        details.text = boundedText(message.text());
      }
      void record("console", details);
    });
    page.on("pageerror", (error) => {
      void record("page_error", { message: boundedText(error.message) });
    });
    page.on("request", (request) => {
      if (!request.isNavigationRequest()) return;
      void record("navigation_request", {
        method: request.method(),
        url: publicUrl(request.url()),
        resourceType: request.resourceType(),
      });
    });
    page.on("requestfailed", (request) => {
      if (!request.isNavigationRequest()) return;
      void record("navigation_request_failed", {
        method: request.method(),
        url: publicUrl(request.url()),
        failure: boundedText(request.failure()?.errorText ?? "unknown"),
      });
    });
    page.on("framenavigated", (frame) => {
      if (frame !== page.mainFrame()) return;
      void record("main_frame_navigated", { url: publicUrl(frame.url()) });
      void updateStatus("interactive", { url: publicUrl(frame.url()) });
    });

    const cdp = await context.newCDPSession(page);
    await cdp.send("Network.enable");
    cdp.on("Network.responseReceived", (event) => {
      if (event.type !== "Document") return;
      void record("document_response", {
        url: publicUrl(event.response.url),
        status: event.response.status,
        protocol: event.response.protocol,
        remoteAddress: event.response.remoteIPAddress || null,
        remotePort: event.response.remotePort || null,
        fromDiskCache: event.response.fromDiskCache,
        fromServiceWorker: event.response.fromServiceWorker,
      });
    });
  }

  context.on("page", (page) => {
    void instrumentPage(page).catch((error) => {
      void record("page_instrumentation_failed", {
        message: boundedText(error instanceof Error ? error.message : error),
      });
    });
  });
  for (const existingPage of context.pages()) await instrumentPage(existingPage);

  const page = context.pages()[0] ?? (await context.newPage());
  await updateStatus("navigating", { target: publicUrl(authUrl.href) });
  const response = await page.goto(authUrl.href, {
    waitUntil: "domcontentloaded",
    timeout: 45_000,
  });
  await page.waitForTimeout(750);

  const bodyText = boundedText(
    await page.locator("body").innerText({ timeout: 5_000 }).catch(() => ""),
    4000,
  );
  const remoteAddress = publicRemoteAddress(
    await response?.serverAddr().catch(() => null),
  );
  const details = {
    url: publicUrl(page.url()),
    statusCode: response?.status() ?? null,
    remoteAddress,
  };

  if (/please enable warp/iu.test(bodyText)) {
    const screenshotPath = runDirectory + "/warp-not-detected.png";
    await page.screenshot({ path: screenshotPath, fullPage: true });
    await chmod(screenshotPath, 0o600);
    await record("warp_not_detected", details);
    await finishStartup("warp_not_detected", details);
  } else if (
    response === null ||
    response.status() < 200 ||
    response.status() >= 400
  ) {
    const screenshotPath = runDirectory + "/unexpected-response.png";
    await page.screenshot({ path: screenshotPath, fullPage: true });
    await chmod(screenshotPath, 0o600);
    await record("unexpected_response", details);
    await finishStartup("unexpected_response", details);
  } else {
    await record("interactive_auth_ready", details);
    await finishStartup("interactive", details);
  }

  await new Promise((resolve) => context.once("close", resolve));
  await eventChain;
} catch (error) {
  const details = {
    message: boundedText(error instanceof Error ? error.stack ?? error.message : error),
  };
  await record("harness_failed", details);
  await finishStartup("failed", details).catch(() => {});
  await closeHarness("startup failure");
  process.exitCode = 1;
}
