{ config, pkgs, inputs, ... }:

{
  imports = [
    ./arduano.nix
    ./hardware-configuration.nix
    ./sdk
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "arduano" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "main-pc";

  services.xserver.enable = true;

  # TODO: Try modern SDDM/Wayland defaults in the next desktop pass.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    settings = {
      General = {
        DisplayServer = "x11";
      };
    };
  };
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
  };

  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.arduano = {
    isNormalUser = true;
    description = "arduano";
    extraGroups = [ "networkmanager" "wheel" "fuse" "docker" "dialout" ];
  };

  users.users.recovery = {
    isNormalUser = true;
    description = "recovery";
    extraGroups = [ "networkmanager" "wheel" "fuse" ];
  };

  nixpkgs.config.allowUnfree = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  boot.kernelParams = [ "nvidia-drm.modeset=1" "fbdev=1" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
