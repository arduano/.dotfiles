# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  system.fsPackages = with pkgs; [ sshfs ];
  boot.supportedFilesystems = [ "bcachefs" ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/a44e5e50-b2c4-497f-b05b-f6cea3cf51d9";
      fsType = "bcachefs";
    };

  fileSystems."/home/arduano" =
    {
      device = "/dev/disk/by-uuid/d67a4d0f-de0e-4e46-bc11-012b053dab72";
      fsType = "bcachefs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/E6EE-7E23";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  # fileSystems."/mnt/z" = {
  #   device = "arduano@192.168.1.51:/mnt/store";
  #   fsType = "sshfs";
  #   options = [
  #     # Filesystem options
  #     "allow_other" # for non-root access
  #     "_netdev" # this is a network fs
  #     # "x-systemd.automount" # mount on demand

  #     # SSH options
  #     "reconnect" # handle connection drops
  #     "delay_connect" # wait for network
  #     "ServerAliveInterval=15" # keep connections alive
  #     "IdentityFile=/home/arduano/.ssh/nas"
  #   ];
  # };

  # swapDevices = [{
  #   device = "/swapfile";
  #   size = 64 * 1024;
  # }];

  nixpkgs.hostPlatform = "x86_64-linux";
}
