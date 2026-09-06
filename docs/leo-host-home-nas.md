# home-nas Leo Multiplex host

`home-nas/home/leo-host.nix` imports the published Home Manager module from the
immutable `leo-multiplex` input. Its tested nixpkgs is independent of the NAS
system pin. This uses main-pc's published host base, including Codex 0.152.0,
with one NAS-only fail-closed `postInstall` substitution: bind the runtime's Iroh
endpoint to `100.82.173.47:0`. Published runtime 0.2.0 has no bind option and its
wildcard listener exceeds p2prpc's 32-direct-address limit on this Docker-heavy
NAS. The patch changes neither peer authorization nor advertised-address policy.
Remove it when a pinned upstream release exposes runtime binding. It does not
update ordinary Codex or the separately installed snapshot
`~/.local/bin/leo-agents`. Model catalog availability is not inference proof.

## Ownership and private input

- Host: `home-nas`, account `arduano`, Codex-only, full account access to the
  explicitly selected existing workdir. Ordinary tmux/Codex sessions are excluded.
- Units: `leo-host.target`, `leo-control.service`, `leo-runtime.service`.
- Control HTTP: loopback TCP 4327. Control transport: Tailscale IP
  `100.82.173.47:49117/udp`; runtime transport: same IP, ephemeral UDP port.
- Canonical state: `~/.local/state/leo-multiplex` (catalog, identities, runtime,
  managed Codex home, transport secret, and pairing artifacts).
- Private input: `~/.local/state/leo-host-input/config.toml`, prepared atomically
  at control startup from the original read-only `~/.codex/config.toml`.
  If the original has no explicit provider, select its existing `codex-lb`
  command-auth provider in the copy. Original auth and OpenClaw are unchanged.
  The upstream host copies only selected provider/model settings into its own
  Codex home. No credentials or private provider contents enter Nix evaluation.

Treat all runtime input, pairing documents and backups as credential-bearing.
Do not print them, commit them, or import them into the Nix store. Retain original
command-auth credential files and backup private host state as a coordinated set.
Never copy a live host's identity to a different host.

## Scoped build and activation

Read current repo changes and service state first. Do not run a whole-system or
Home Manager activation just for this addition: unrelated changes may be pending.
Build only the three generated Home Manager unit derivations:

```sh
nix build --impure --no-link --print-out-paths --expr '
  let
    s = (builtins.getFlake "/home/arduano/.dotfiles").nixosConfigurations.home-nas;
    f = s.config.home-manager.users.arduano.home.file;
  in s.pkgs.runCommand "leo-host-units" {} ("mkdir -p $out\n" +
    builtins.concatStringsSep "\n" (map
      (n: "ln -s ${f."/home/arduano/.config/systemd/user/${n}".source} $out/${n}")
      [ "leo-control.service" "leo-runtime.service" "leo-host.target" ]))'
```

Verify generated units and upstream `nix/verify-host.mjs` before starting. Install
only these unit symlinks under `~/.config/systemd/user`, pointing to their built
store files; root their store directories with `nix-store --add-root ... -r` under
`~/.local/state/leo-host-deployment`. Enable only these units/target. A later normal
Home Manager activation may assume ownership of these matching symlinks.

## First enrollment

Only for a new host with no sessions:

1. Verify TCP 4327 and UDP 49117 are free and both private state paths are new.
2. The current gateway uses a single shared transport credential for all sources.
   Seed the new host's `shared-secret` from the existing private gateway pairing
   JSON using a file-to-file program, mode 0600 in a mode 0700 directory. Never
   copy main-pc's identities or print the secret. Do not generate a different
   secret and overwrite the existing gateway credential.
3. Add a temporary **runtime** drop-in for NAS `leo-control.service`, enabling
   `LEO_ENROLL_RUNTIMES=1` and `LEO_ENROLL_GATEWAYS=1`. Start the new target.
4. Privately back up `~/host/leo-multiplex/config/gateway-pairing.json`. Merge the
   new host's generated source into its `sources` array, asserting equal shared
   secrets and unique source/endpoint IDs. Preserve existing sources exactly.
   Atomically replace the pairing file with mode 0600. Never use the upstream
   single-host copy script here: that would replace the main-pc source.
5. Restart only the existing NAS `leo-multiplex-web` gateway container to read
   the source list. Client connections briefly drop; main-pc services and native
   sessions must not be restarted or changed.
6. Confirm both hosts via `leo-agents hosts`, and NAS `profiles` / `models`.
7. Remove only the temporary enrollment drop-in, daemon-reload, and restart only
   NAS `leo-control.service`. Verify both enrollment flags are zero, the runtime
   PID is unchanged, and both hosts reconnect. Never leave enrollment open.

## Verification and limits

`leo-agents hosts`, `profiles --host home-nas`, and `models --host home-nas` are
read-only registration/catalog checks. They are not proof of successful model
inference or complete Astra protocol support in Codex 0.152.0. Do not send prompts
without fresh explicit permission. Disposable idle lifecycle checks, if used,
must own their workdir, IDs and state and must not adopt existing sessions.

### Deployment evidence — 2026-09-06

- Runtime host ID: `01a07492-b518-72c0-b992-224b9dc46721`, `home-nas`.
- Base public revision: `3181e95fcff366e15e8348367fe0c835e3c8ba1e`.
- Patched package: `/nix/store/pmyqncsdfgi62bz4vyc8dx8xd9r802zy-leo-multiplex-0.1.0`.
- Rooted units: `/nix/store/3ik83szd68yibw2lfcs6nghs3rn4qrxq-leo-host-units`.
- Built locally; Nix parse, generated systemd-unit verification, upstream
  no-inference native import/SQLite/Codex-version verifier all passed.
- Runtime-source fixture verified absent-provider selection, explicit-provider
  preservation, original-file preservation, private permissions, and rejection
  of missing command authentication; no auth helpers were executed by that test.
- `leo-agents hosts`: both hosts online/reachable after closing enrollment.
  NAS profile `leo.local/workspace` available; 13 model catalog entries, including
  `gpt-6-astra` with low/medium/high/xhigh/max/ultra reasoning options.
- NAS runtime PID survived control-only enrollment closure with zero restarts.
  main-pc control/runtime and OpenClaw PIDs/start timestamps unchanged; original
  NAS Codex and live OpenClaw configurations byte-identical. Gateway healthy.
- No session launch/resume/stop, no tmux adoption, no prompts or inference.
  Idle disposable lifecycle and real model execution remain untested.
- Private pre-addition pairing backup:
  `~/.local/state/leo-host-deployment/backups/2026-09-06-initial/`.
  Private audit artifacts: `~/.local/state/leo-host-deployment/audit-20260906/`.

For rollback, first inspect whether this NAS host has acquired real sessions.
Stop only its target after appropriate authorization, retain all private state,
restore the private pre-addition gateway pairing backup, and restart only the NAS
gateway. Never delete identities/catalogs to force recovery. The main-pc and
OpenClaw service/configuration boundaries remain unchanged.
