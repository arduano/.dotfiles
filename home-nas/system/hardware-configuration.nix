{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.initrd.systemd.enable = true;
  hardware.enableRedistributableFirmware = true;

  fileSystems."/" =
    {
      device = "UUID=aa5beb5c-ede2-4bf5-a042-f56bb0a7adc2";
      fsType = "bcachefs";
      options = [
        "degraded"
        "x-systemd.requires=/dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV2NDW6"
        "x-systemd.requires=/dev/disk/by-id/ata-WDC_WD80EFPX-68C4ZN0_WD-RD1B44VD"
        "x-systemd.requires=/dev/disk/by-id/ata-WDC_WD80EFPX-68C4ZN0_WD-RD1DNDWD"
        "x-systemd.requires=/dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV2NBA6"
        "x-systemd.requires=/dev/disk/by-id/nvme-eui.0025385581b21585-part2"
      ];
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
