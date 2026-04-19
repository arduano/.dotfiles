{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  hardware.enableRedistributableFirmware = true;

  fileSystems."/" =
    {
      device = "/dev/disk/by-id/ata-WDC_WD80EFPX-68C4ZN0_WD-RD1B44VD:/dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV2NBA6:/dev/disk/by-id/ata-WDC_WD80EFPX-68C4ZN0_WD-RD1DNDWD:/dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV2NDW6:/dev/disk/by-id/nvme-eui.0025385581b21585-part2";
      fsType = "bcachefs";
      options = [
        "degraded"
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
