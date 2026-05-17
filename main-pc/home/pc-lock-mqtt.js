#!/usr/bin/env node

// Tiny MQTT v3.1.1 subscriber for locking the KDE/Plasma session on main-pc.
// Intentionally dependency-free so it can live comfortably inside Nix/Home Manager.

const net = require("node:net");
const { execFile } = require("node:child_process");
const os = require("node:os");

const cfg = {
  host: process.env.MQTT_HOST || "home-nas",
  port: Number(process.env.MQTT_PORT || 1883),
  username: process.env.MQTT_USERNAME || "",
  password: process.env.MQTT_PASSWORD || "",
  topic: process.env.MQTT_TOPIC || "home/main-pc/lock/set",
  statusTopic: process.env.MQTT_STATUS_TOPIC || "home/main-pc/lock/status",
  clientId: process.env.MQTT_CLIENT_ID || `main-pc-lock-${os.hostname()}`,
  keepaliveSeconds: Number(process.env.MQTT_KEEPALIVE_SECONDS || 30),
  reconnectMinMs: Number(process.env.MQTT_RECONNECT_MIN_MS || 1000),
  reconnectMaxMs: Number(process.env.MQTT_RECONNECT_MAX_MS || 30000),
  lockCommand: process.env.LOCK_COMMAND || "qdbus",
  lockArgs: process.env.LOCK_ARGS
    ? JSON.parse(process.env.LOCK_ARGS)
    : ["org.kde.screensaver", "/ScreenSaver", "org.freedesktop.ScreenSaver.Lock"],
};

let packetId = 1;
let reconnectMs = cfg.reconnectMinMs;
let socket = null;
let pingTimer = null;
let reconnectTimer = null;
let lastLockAt = 0;
let buffer = Buffer.alloc(0);

function log(message) {
  console.log(`${new Date().toISOString()} ${message}`);
}

function fail(message) {
  console.error(`${new Date().toISOString()} ${message}`);
}

function encodeString(value) {
  const body = Buffer.from(value, "utf8");
  const out = Buffer.alloc(2 + body.length);
  out.writeUInt16BE(body.length, 0);
  body.copy(out, 2);
  return out;
}

function encodeRemainingLength(value) {
  const bytes = [];
  do {
    let encoded = value % 128;
    value = Math.floor(value / 128);
    if (value > 0) encoded |= 128;
    bytes.push(encoded);
  } while (value > 0);
  return Buffer.from(bytes);
}

function packet(typeAndFlags, body = Buffer.alloc(0)) {
  return Buffer.concat([Buffer.from([typeAndFlags]), encodeRemainingLength(body.length), body]);
}

function nextPacketId() {
  packetId = packetId >= 0xffff ? 1 : packetId + 1;
  return packetId;
}

function connectPacket() {
  const variableHeader = Buffer.concat([
    encodeString("MQTT"),
    Buffer.from([4]), // MQTT 3.1.1
    Buffer.from([
      0x02 | // clean session
        (cfg.username ? 0x80 : 0) |
        (cfg.password ? 0x40 : 0),
    ]),
    Buffer.from([cfg.keepaliveSeconds >> 8, cfg.keepaliveSeconds & 0xff]),
  ]);

  const payloadParts = [encodeString(cfg.clientId)];
  if (cfg.username) payloadParts.push(encodeString(cfg.username));
  if (cfg.password) payloadParts.push(encodeString(cfg.password));

  return packet(0x10, Buffer.concat([variableHeader, ...payloadParts]));
}

function subscribePacket(topic) {
  const id = nextPacketId();
  const variableHeader = Buffer.from([id >> 8, id & 0xff]);
  const payload = Buffer.concat([encodeString(topic), Buffer.from([0])]); // QoS 0
  return packet(0x82, Buffer.concat([variableHeader, payload]));
}

function publishPacket(topic, payload, { retain = false } = {}) {
  return packet(0x30 | (retain ? 1 : 0), Buffer.concat([encodeString(topic), Buffer.from(payload, "utf8")]));
}

function publishStatus(status) {
  if (!socket || socket.destroyed || !cfg.statusTopic) return;
  socket.write(publishPacket(cfg.statusTopic, status, { retain: true }));
}

function parsePackets(chunk) {
  buffer = Buffer.concat([buffer, chunk]);

  while (buffer.length >= 2) {
    let multiplier = 1;
    let remainingLength = 0;
    let offset = 1;
    let encodedByte;

    do {
      if (offset >= buffer.length) return;
      encodedByte = buffer[offset++];
      remainingLength += (encodedByte & 127) * multiplier;
      multiplier *= 128;
      if (multiplier > 128 * 128 * 128) throw new Error("Malformed MQTT remaining length");
    } while ((encodedByte & 128) !== 0);

    const totalLength = offset + remainingLength;
    if (buffer.length < totalLength) return;

    const fixedHeader = buffer[0];
    const body = buffer.subarray(offset, totalLength);
    buffer = buffer.subarray(totalLength);
    handlePacket(fixedHeader, body);
  }
}

function handlePacket(fixedHeader, body) {
  const packetType = fixedHeader >> 4;

  switch (packetType) {
    case 2: { // CONNACK
      const rc = body[1];
      if (rc !== 0) throw new Error(`MQTT CONNACK failed with code ${rc}`);
      log(`connected to MQTT ${cfg.host}:${cfg.port}; subscribing to ${cfg.topic}`);
      reconnectMs = cfg.reconnectMinMs;
      socket.write(subscribePacket(cfg.topic));
      publishStatus("online");
      break;
    }
    case 3: { // PUBLISH, QoS 0 only expected
      const topicLength = body.readUInt16BE(0);
      const topic = body.subarray(2, 2 + topicLength).toString("utf8");
      const payload = body.subarray(2 + topicLength).toString("utf8").trim();
      if (topic === cfg.topic) handleCommand(payload);
      break;
    }
    case 9: // SUBACK
      log(`subscribed to ${cfg.topic}`);
      break;
    case 13: // PINGRESP
      break;
    default:
      break;
  }
}

function handleCommand(payload) {
  const normalized = payload.toLowerCase();
  if (!["lock", "locked", "1", "true", "on"].includes(normalized)) {
    log(`ignored payload on ${cfg.topic}: ${JSON.stringify(payload)}`);
    return;
  }

  const now = Date.now();
  if (now - lastLockAt < 2000) {
    log("ignored duplicate lock command within debounce window");
    return;
  }
  lastLockAt = now;

  lockScreen();
}

function lockScreen() {
  const uid = process.getuid?.() ?? 1000;
  const env = {
    ...process.env,
    XDG_RUNTIME_DIR: process.env.XDG_RUNTIME_DIR || `/run/user/${uid}`,
    DBUS_SESSION_BUS_ADDRESS: process.env.DBUS_SESSION_BUS_ADDRESS || `unix:path=/run/user/${uid}/bus`,
  };

  log(`locking screen via ${cfg.lockCommand} ${cfg.lockArgs.join(" ")}`);
  execFile(cfg.lockCommand, cfg.lockArgs, { env }, (error, stdout, stderr) => {
    if (stdout.trim()) log(stdout.trim());
    if (stderr.trim()) fail(stderr.trim());

    if (error) {
      fail(`lock command failed: ${error.message}`);
      publishStatus("lock_failed");
    } else {
      publishStatus("locked");
    }
  });
}

function connect() {
  clearTimeout(reconnectTimer);
  buffer = Buffer.alloc(0);

  socket = net.createConnection({ host: cfg.host, port: cfg.port }, () => {
    socket.write(connectPacket());
    pingTimer = setInterval(() => {
      if (socket && !socket.destroyed) socket.write(packet(0xc0));
    }, Math.max(5, cfg.keepaliveSeconds - 5) * 1000);
  });

  socket.on("data", (chunk) => {
    try {
      parsePackets(chunk);
    } catch (error) {
      fail(error.stack || error.message);
      socket.destroy(error);
    }
  });

  socket.on("error", (error) => {
    fail(`MQTT socket error: ${error.message}`);
  });

  socket.on("close", () => {
    clearInterval(pingTimer);
    publishStatus("offline");
    const delay = reconnectMs;
    reconnectMs = Math.min(cfg.reconnectMaxMs, reconnectMs * 2);
    fail(`MQTT disconnected; reconnecting in ${delay}ms`);
    reconnectTimer = setTimeout(connect, delay);
  });
}

process.on("SIGINT", () => process.exit(0));
process.on("SIGTERM", () => process.exit(0));

connect();
