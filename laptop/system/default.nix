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
  arduano.roles.desktop-laptop.enable = true;

  networking.hostName = "laptop";

  # Enable exit node settings for tailscale
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
