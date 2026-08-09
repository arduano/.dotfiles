{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    (import ./share/overlayModule.nix)
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Universal investigation/recovery/installer ISO for mystery x86_64 laptops.
  # Bias toward firmware, conservative graphics, legacy boot, and diagnostics.
  hardware.enableRedistributableFirmware = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    # Common workaround for Intel laptop-panel flicker/blanking on older i915 panels.
    "i915.enable_psr=0"
    # Helpful once the board is removed from the laptop shell / lid magnet geometry.
    "button.lid_init_state=open"
  ];

  boot.initrd.availableKernelModules = [
    "ahci" "ata_piix" "ehci_pci" "sd_mod" "sdhci_pci" "usb_storage" "uhci_hcd" "xhci_pci"
    "i915" "rtsx_pci_sdmmc"
  ];

  boot.supportedFilesystems = lib.mkForce [
    "bcachefs" "btrfs" "cifs" "exfat" "ext4" "f2fs" "jfs" "ntfs" "reiserfs" "vfat" "xfs"
  ];

  users.users.nixos = {
    initialHashedPassword = lib.mkForce null;
    initialPassword = "nixos";
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
  };
  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "nixos-recovery-live";
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  services.acpid.enable = true;
  services.thermald.enable = true;

  # Small, old-GPU-friendly graphical fallback for live investigation.
  # No autologin and no autostarts; log in as nixos/nixos and run startx if wanted.
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" "fbdev" "vesa" ];
    xkb = {
      layout = "us";
      variant = "";
    };
    windowManager.openbox.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    # Browser/manual GUI tools.
    chromium
    firefox
    xdpyinfo
    xev
    xinput
    xrandr
    xterm

    # Bring-up/diagnostics on mystery laptops.
    acpi
    dmidecode
    efibootmgr
    ethtool
    gparted
    nvme-cli
    testdisk
    hdparm
    iw
    lshw
    lm_sensors
    pciutils
    powertop
    smartmontools
    usbutils
    wget
    curl

    # Install/filesystem tooling.
    bcachefs-tools
    dosfstools
    exfatprogs
    ntfs3g
    parted
    rsync
  ] ++ pkgs.arduano.groups.shell-essentials;
}
