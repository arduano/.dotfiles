{ config, pkgs, inputs, lib, ... }:

{
  imports = [ ];

  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  # networking.interfaces.enp5s0.ipv4.addresses = [{
  #   address = "192.168.1.52";
  #   prefixLength = 24;
  # }];
  # networking.defaultGateway = "192.168.1.1";
  # networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  # networking.firewall.enable = false;

  networking.firewall.enable = false;
  # networking.nftables.enable = true;
  # networking.nftables.ruleset = ''
  #   table inet filter {
  #     chain input {
  #       type filter hook input priority 0; policy drop;

  #       # Allow all loopback traffic
  #       iif "lo" accept

  #       # Allow established and related connections
  #       ct state established,related accept

  #       # Allow incoming traffic from 100.0.0.0/8 for Tailscale
  #       ip saddr 100.0.0.0/8 accept

  #       # Allow ICMP Echo Requests (Ping)
  #       icmp type echo-request accept
  #       ip6 nexthdr icmpv6 icmpv6 type { echo-request } accept
  #     }
  #   }
  # '';

  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
}
