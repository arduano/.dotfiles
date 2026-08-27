# Work VM NixOS module

`arduano.workVm` provides a reusable host-side boundary for a work virtual
machine without storing employer, tenant, account, repository, or machine
identifiers in dotfiles.

The module currently provides:

- a dedicated Linux network namespace and NAT uplink;
- a dedicated nftables table that coexists with Docker's existing firewall
  backend instead of changing the host's global firewall mode;
- Cloudflare WARP confined to that namespace;
- fail-closed handling for expected private routes, so they cannot fall back
  through the ordinary host uplink when WARP is unavailable or misconfigured;
- isolation from host services and new connections forwarded in from other
  networks, while preserving replies to host-originated viewer/SSH sessions;
- a writable namespace-local resolver file, preventing WARP from changing the
  host resolver;
- `work-vm-netns-exec`, used to launch QEMU inside the namespace;
- `work-vm-warp`, an unprivileged CLI for enrollment and status checks against
  the namespace daemon;
- `work-vm-warp-reauth`, a narrow socket-activated SSH/CLI harness that opens a
  persistent auth-browser profile inside the namespace and waits for three
  consecutive HTTPS passes against caller-supplied protected hosts; and
- a non-secret list of expected private destination IPv4 CIDRs for auditing and
  fail-closed enforcement.

The firewall has no separate enable/disable command or helper script. Its
dedicated table follows `arduano.workVm.enable`: change the NixOS configuration
and run `nixos-rebuild switch` to add, update, or remove it. Do not manage the
generated `work-vm-firewall.service` as an operator-facing lifecycle control.

Enrollment is deliberately runtime state. Do not put the Zero Trust team name,
authentication URL, device token, identity, or organization-managed policy in
this repository. After activation, enroll interactively as the regular desktop user with:

```console
work-vm-warp --accept-tos registration new TEAM_NAME
work-vm-warp --accept-tos connect
work-vm-warp --accept-tos status
```

The daemon IPC socket is host-visible, so the CLI does not need to enter the
root-owned namespace. Keep authentication tokens and callback URLs out of shell
history, logs, and reports.

Trigger routine reauthentication locally or over SSH with:

```console
work-vm-warp-reauth PROTECTED_HOST [PROTECTED_HOST...]
# or
ssh main-pc work-vm-warp-reauth PROTECTED_HOST [PROTECTED_HOST...]
```

The client exits successfully only after the socket-bound server emits its
schema-qualified, three-pass protected-HTTPS completion receipt. A closed
connection or browser-launch failure is terminal even when the socket
transport itself exits cleanly.

The harness opens a headed Chromium persistent profile through Playwright on
the active desktop. Playwright owns navigation instead of handing the URL to a
desktop browser or simulating keyboard input. The browser is routed through the
`work-vm` namespace and bound to its WARP-managed resolver rather than the host
resolver. Before navigation, the launcher resolves the authentication host
explicitly through WARP DNS, then maps that validated IPv4 address in the
dedicated Chromium process. It deliberately does not require libc resolution:
split-DNS names are not necessarily available through the namespace's first
general resolver. This keeps browser DoH and HTTPS/SVCB address hints from
bypassing hostname-based split inclusion. Browser QUIC is disabled to avoid
racing the host's enforced MASQUE HTTP/2 path.

Each attempt writes a private, mode-0700 run directory below
`$XDG_STATE_HOME/work-vm-warp-auth/runs/`. Its sanitized JSONL events, live
status, startup result, browser log, remote response address, and failure
screenshot make the auth path inspectable without desktop-control tooling.
Default events retain only URL origins and omit console text. Playwright
tracing and console text are disabled by default because they can contain
authentication state. They may be enabled only through an explicit private
service environment with `WORK_VM_WARP_AUTH_TRACE=1`.

Complete the identity-provider flow in the headed window and approve the
two-digit phone notification; the command returns only after every
caller-supplied host passes protected HTTPS three times in a row.
Workload repositories own those hostnames and the stronger end-to-end VM
validation; this generic module does not embed organization-specific
endpoints. The first use may require signing into the dedicated browser
profile; later reauthentication can reuse its identity-provider session.

The team administrator must ensure the intended private routes are included by
the Zero Trust device profile. Cloudflare commonly excludes CGNAT/private
ranges by default; the local client cannot safely override an
organization-managed split-tunnel policy.

QEMU must be launched through `sudo work-vm-netns-exec /absolute/path ...`.
The helper requires an absolute executable path, needs root only to enter the
namespace, then drops back to the invoking sudo user before starting QEMU.
Existing VM disks and hardware configuration remain
outside this module for now; this module is the reusable network/VPN boundary
and can be expanded as those pieces are made declarative.
