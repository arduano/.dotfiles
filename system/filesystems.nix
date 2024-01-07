{ config, pkgs, inputs, ... }:

{
  system.fsPackages = with pkgs; [ sshfs ];

  fileSystems."/home/arduano" =
    {
      device = "/dev/disk/by-uuid/9a3e36de-d2f2-4021-a10f-3f134fd8f62f";
      fsType = "ext4";
    };

  fileSystems."/mnt/fat" =
    {
      device = "/dev/disk/by-uuid/430eda30-4901-4aec-9fa5-69ab8cb322df";
      fsType = "btrfs";
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
        "ServerAliveInterval=15" # keep connections alive
        "IdentityFile=/home/arduano/.ssh/nas"
      ];
  };
}
