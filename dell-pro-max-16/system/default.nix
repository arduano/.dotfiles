{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  arduano.roles.base = {
    enable = true;
    createUserHomes = true;
    arduanoExtraGroups = [ "docker" "dialout" ];
  };
  arduano.roles.desktop-laptop.enable = true;

  networking.hostName = "dell-pro-max-16";
  networking.networkmanager.enable = true;

  # This SSD is initially a portable, removable-system install. Avoid writing
  # a boot entry into main-pc's firmware; systemd-boot also installs the UEFI
  # fallback loader at EFI/BOOT/BOOTX64.EFI.
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  boot.loader.timeout = 3;
  boot.loader.systemd-boot.configurationLimit = 5;

  # systemd initrd supplies a proper ask-password prompt for native bcachefs
  # encryption before mounting the root filesystem.
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "bcachefs" ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  hardware.graphics.enable = true;
  services.thermald.enable = true;
  services.fstrim.enable = true;
  zramSwap.enable = true;

  programs.steam.enable = true;
  virtualisation.docker.enable = true;

  users.users.arduano.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICTRANHakQog7l2Ftk/3EtcExKJJ1PmG8lytv+9LXxl9 arduano@home-nas"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCv+fD8ko7919jXoyMQMRO1F7Ff44ZT+vPBVV0DY1yuh3+T5+S0znJeo8qoEr7jYwElK4fJ9df9gX2Bzd4l9fBMqnXcVeNXXv+TSygpdybGpi/AF5jFc1oA8M4T0VABdNUrhbn8D6PpY4bFRCVu6kV5FhFtqAE4MHFPPmEjyP5mTRkdYaoNYsyjJehv6oYNkoocUPdFVtfR5cFndu+0bi3koCiVf9jVp/7myeGX5DAgZ48alCIHlmuKcmYSQ8d+TPY0JSFedNIyBCxRQDIM6E9+uQ6/VaeTY+AVtRKlv9HM4SDtWihxZ2weUxxdj0pYmIGwyc1fN+vbIKkKG15sYwm/fxtB2vEA5SAfQmOeZnP9GpMu3Z0qrW+G55QUXmd7dZy+xEgYGeTRAEd1YRv0Fl4M3sxV2i+KVwzviUULot5KEgV1OiyOwrkK0iZCceTnva+ptT7WrCwl+koz4WieKx1rDcQ2fnl1dTdi01BOjoat+mL2sHCuNRs76CUt5DXF/gs= main_pc.pub"
  ];

  services.openssh = {
    enable = true;
    ports = [ 45754 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedTCPPorts = [ 45754 ];
  };

  environment.systemPackages = with pkgs; [
    bcachefs-tools
    git
    pciutils
    smartmontools
    usbutils
  ];

  system.stateVersion = "26.11";
}
