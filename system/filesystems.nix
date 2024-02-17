{ config, pkgs, inputs, ... }:

{
  system.fsPackages = with pkgs; [ sshfs ];
  boot.supportedFilesystems = [ "bcachefs" ];

  fileSystems."/home/arduano" =
    {
      device = "/dev/disk/by-uuid/9a3e36de-d2f2-4021-a10f-3f134fd8f62f";
      fsType = "ext4";
    };

  # fileSystems."/mnt/fat" =
  #   {
  #     # device = "/dev/disk/by-partuuid/27b59535-73da-4aaf-be97-87c9205be787:/dev/disk/by-partuuid/a905ac1e-4f85-914e-a929-843aea587ef3";
  #     device = "/dev/nvme0n1p2:/dev/sdc1";
  #     fsType = "bcachefs";
  #     options = [ "verbose" "nofail" "noatime" "x-systemd.device-timeout=10s" ];
  #     # options = [ "compression=zstd" ];
  #   };

  # TODO: Using a oneshot service at the moment as the above doesn't work
  systemd.services.init-fat = {
    after = [ "multi-user.target" ];
    enable = true;
    script = ''
      ${pkgs.mount}/bin/mount -t bcachefs /dev/disk/by-partuuid/27b59535-73da-4aaf-be97-87c9205be787:/dev/disk/by-partuuid/a905ac1e-4f85-914e-a929-843aea587ef3 /mnt/fat
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Group = "root";
    };
  };

  fileSystems."/mnt/z" = {
    device = "arduano@192.168.1.51:/mnt/raid5";
    fsType = "sshfs";
    options =
      [
        # Filesystem options
        "allow_other" # for non-root access
        "_netdev" # this is a network fs
        # "x-systemd.automount" # mount on demand

        # SSH options
        "reconnect" # handle connection drops
        "delay_connect" # wait for network
        "ServerAliveInterval=15" # keep connections alive
        "IdentityFile=/home/arduano/.ssh/nas"
      ];
  };

  swapDevices = [{
    device = "/swapfile";
    size = 64 * 1024;
  }];
}
