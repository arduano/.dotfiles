{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  # Keep systemd stage 1 enabled even though we previously worked around boot
  # failures by setting this to false. Scripted stage 1 is deprecated in 26.05
  # and scheduled for removal in 26.11, so the long-term fix needs to work with
  # systemd initrd instead of opting out of it.
  boot.initrd.systemd.enable = true;
  hardware.enableRedistributableFirmware = true;

  fileSystems."/" =
    {
      # Mount the bcachefs root by its external filesystem UUID instead of a
      # colon-joined member list. systemd treats multi-device "What=" values as
      # one backing device and can end up waiting on a nonexistent .device unit:
      # - systemd/systemd#8234
      # - NixOS/nixpkgs#72970
      #
      # The filesystem UUID was read from the live host via udevadm/blkid.
      device = "UUID=aa5beb5c-ede2-4bf5-a042-f56bb0a7adc2";
      fsType = "bcachefs";
      options = [
        # Root should still mount if one member is temporarily missing.
        "degraded"
        # systemd initrd still needs explicit ordering on the real constituent
        # devices, otherwise bcachefs root can race device discovery and fail
        # with insufficient devices or sit waiting before any real mount work:
        # - NixOS/nixpkgs#451418
        #
        # Keep these as stable by-id paths, not /dev/sdX names.
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
