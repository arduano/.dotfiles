{ lib, ... }:

let
  borgRepo = "/mnt/store/archive/borg/home-nas";
in
{
  # Duplicati was left installed after the NAS reimage but had no live jobs,
  # schedules, or operation history. Borg is a better fit here because the
  # config is declarative, local-first, and easy to rebuild from NixOS state.
  services.duplicati.enable = lib.mkForce false;

  services.borgbackup.jobs.home-nas = {
    # Run as root so the backup can read system-owned config/state paths.
    user = "root";
    group = "root";

    paths = [
      "/home/arduano"
      "/etc/ssh"
      "/etc/NetworkManager/system-connections"
      "/var/lib/tailscale"
    ];

    repo = borgRepo;
    encryption.mode = "none";
    compression = "zstd,3";

    # If the NAS was off during the scheduled time, run the missed backup on boot.
    startAt = "daily";
    persistentTimer = true;

    # This NAS has plenty of data that changes while services are live; warnings
    # for "file changed while we were reading it" should not mark the job failed.
    failOnWarnings = false;

    prune.keep = {
      within = "2d";
      daily = 7;
      weekly = 6;
      monthly = 12;
    };

    exclude = [
      # Borg repo itself (future-proof if paths ever broaden).
      borgRepo

      # Large caches / ephemeral state.
      "/home/arduano/.cache"
      "/home/arduano/.npm/_cacache"
      "/home/arduano/.local/share/Trash"
      "/home/arduano/.local/state/nix"
      "/home/arduano/.cargo"
      "/home/arduano/.rustup"
      "/home/arduano/.vscode-server"
      "/home/arduano/.bun/install/cache"

      # Backup-app data we do not want to recurse or preserve.
      "/home/arduano/.config/Duplicati"
      "/var/lib/duplicati"

      # Bulky/generated data that is low-value for snapshot-style config backups.
      "/home/arduano/host/clips-share"
      "/home/arduano/host/ipfs"
    ];
  };
}
