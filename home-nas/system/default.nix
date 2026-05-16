{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./borgbackup.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "home-nas"; # Define your hostname.

  arduano.networking.enable = true;
  arduano.shell.enable = true;
  arduano.locale.enable = true;

  networking.useDHCP = lib.mkDefault true;
  networking.firewall.enable = false;

  environment.systemPackages = (with pkgs.arduano.groups;
    build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming)
  ++ [ pkgs.chromium pkgs.arduano.gogcli ];

  virtualisation.docker.enable = true;

  users.users.arduano = {
    isNormalUser = true;
    createHome = true;
    description = "arduano";
    extraGroups = [ "networkmanager" "wheel" "fuse" "docker" ];
  };
  users.users.recovery = {
    isNormalUser = true;
    createHome = true;
    description = "recovery";
    extraGroups = [ "networkmanager" "wheel" "fuse" ];
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      AllowTcpForwarding = "yes";
    };
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

  services = {
    syncthing = {
      enable = true;
      user = "arduano";
      configDir = "/home/arduano/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.duplicati = {
    enable = true;
    user = "arduano";
  };
  # TODO: Replace Duplicati with Borg in a backup-specific cleanup pass.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
