{ config, pkgs, inputs, lib, ... }:

{
  imports = [ ./tailscale.nix ];

  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.interfaces.enp5s0.ipv4.addresses = [{
    address = "192.168.1.52";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  networking.firewall.enable = false;

  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
}
