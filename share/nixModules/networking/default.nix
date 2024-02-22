{ pkgs, lib, config, ... }:

with lib;
let
  nixPath = "/run/nixPath";

  cfg = config.arduano.networking;
in
{
  options = {
    arduano.networking =
      {
        enable = mkEnableOption "networking";
        useFirewall = mkEnableOption "use firewall";
      };
  };

  config =
    let
      networking = mkIf cfg.enable
        {
          networking.networkmanager.enable = true;

          # https://github.com/NixOS/nixpkgs/issues/180175
          systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
          systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

          services.tailscale.enable = true;

          networking.firewall.enable = false;
        };
      useFirewall = mkIf cfg.useFirewall
        {
          networking.nftables.enable = true;
          networking.nftables.ruleset = ''
            table inet filter {
              chain input {
                type filter hook input priority 0; policy drop;

                # Allow all loopback traffic
                iif "lo" accept

                # Allow established and related connections
                ct state established,related accept

                # Allow incoming traffic from 100.0.0.0/8 for Tailscale
                ip saddr 100.0.0.0/8 accept

                # Allow ICMP Echo Requests (Ping)
                icmp type echo-request accept
                ip6 nexthdr icmpv6 icmpv6 type { echo-request } accept
              }
            }
          '';
        };
    in
    mkMerge [ networking useFirewall ];
}
