{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "iptable_nat" "iptable_filter" ];
  boot.extraModulePackages = [ ];
  hardware.enableRedistributableFirmware = true;

  fileSystems."/" =
    {
      device = "/dev/sda:/dev/sdb:/dev/sdc:/dev/sdd:/dev/nvme0n1p2";
      fsType = "bcachefs";
      options = [ "degraded" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices = [{
    device = "/dev/nvme0n1p3";
  }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
