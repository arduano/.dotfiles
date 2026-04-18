{ lib, ... }:

let
  borgRepo = "/mnt/store/archive/shared/home-nas";
in
{
  # Duplicati was left installed after the NAS reimage but had no live jobs,
  # schedules, or operation history. Borg is a better fit here because the
  # config is declarative, local-first, and easy to rebuild from NixOS state.
  services.duplicati.enable = lib.mkForce false;

  services.borgbackup.jobs.home-nas = {
    # ~/host contains mixed-ownership container data, so the backup job needs
    # root-level read access to avoid permission-denied holes.
    user = "root";
    group = "root";

    paths = [
      "/home/arduano/host"
      "/home/arduano/.openclaw"
    ];

    repo = borgRepo;
    encryption.mode = "none";
    compression = "zstd,3";

    # If the NAS was off during the scheduled time, run the missed backup on boot.
    startAt = "daily";
    persistentTimer = true;

    # Live app data can change during reads; warnings shouldn't turn the whole
    # backup red for this local snapshotting use case.
    failOnWarnings = false;

    prune.keep = {
      within = "2d";
      daily = 7;
      weekly = 6;
      monthly = 12;
    };

    exclude = [
      # Never recurse into the repository itself.
      borgRepo
    ];
  };
}
