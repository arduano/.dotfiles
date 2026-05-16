{ config, pkgs, inputs, ... }:

{
  imports = [
    ./arduano.nix
    ./hardware-configuration.nix
  ];

  arduano.roles.base = {
    enable = true;
    arduanoExtraGroups = [ "docker" "dialout" ];
  };
  arduano.roles.desktop-main-pc.enable = true;
  arduano.roles.main-pc-hardware-workbench.enable = true;

  nix.settings.trusted-users = [ "root" "arduano" ];

  networking.hostName = "main-pc";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
