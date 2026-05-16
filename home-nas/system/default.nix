{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./borgbackup.nix
  ];

  arduano.roles.base = {
    enable = true;
    createUserHomes = true;
    arduanoExtraGroups = [ "docker" ];
  };
  arduano.roles.server-common.enable = true;

  networking.hostName = "home-nas"; # Define your hostname.

  networking.useDHCP = lib.mkDefault true;
  networking.firewall.enable = false;

  environment.systemPackages = [ pkgs.chromium pkgs.arduano.gogcli ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      AllowTcpForwarding = "yes";
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
