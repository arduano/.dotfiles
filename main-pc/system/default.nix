{ config, pkgs, inputs, ... }:

{
  imports = [
    ./arduano.nix
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "arduano" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "main-pc";

  # Desktop/display stack.
  #
  # Current test baseline: Plasma on Wayland, including SDDM's Wayland greeter,
  # with the NVIDIA open kernel module. Keep this block easy to find while the
  # Wayland migration settles; if it remains stable, the comments can be trimmed
  # and this should be treated as the normal desktop configuration.
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = [ "nvidia" ];
    };

    displayManager = {
      defaultSession = "plasma";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    desktopManager.plasma6.enable = true;
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

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
