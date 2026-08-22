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
  consecutive protected HTTPS passes; and
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
work-vm-warp-reauth
# or
ssh main-pc work-vm-warp-reauth
```

The harness opens a dedicated persistent Brave profile on the active desktop,
routed through the `work-vm` namespace. Complete the identity-provider flow and
approve the two-digit phone notification; the command returns only after
DevTools Build Targets, ProGet, and Crikey pass protected HTTPS three times in
a row. The first use may require signing into the dedicated browser profile;
later reauthentication can reuse its identity-provider session.

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
