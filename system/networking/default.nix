{ config, pkgs, inputs, ... }:

{
  imports = [ ./tailscale.nix ];

  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.interfaces.enp5s0.ipv4.addresses = [{
    address = "192.168.1.11";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  networking.firewall.enable = false;
}
