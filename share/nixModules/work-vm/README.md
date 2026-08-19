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
- `work-vm-warp`, used for one-time interactive enrollment and later status
  checks; and
- a non-secret list of expected private destination IPv4 CIDRs for auditing and
  fail-closed enforcement.

Enrollment is deliberately runtime state. Do not put the Zero Trust team name,
authentication URL, device token, identity, or organization-managed policy in
this repository. After activation, enroll interactively with:

```console
sudo work-vm-warp --accept-tos registration new TEAM_NAME
sudo work-vm-warp mode tunnel_only
sudo work-vm-warp connect
sudo work-vm-warp status
```

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
