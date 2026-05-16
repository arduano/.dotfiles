{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.arduano.networking;
in
{
  options = {
    arduano.networking = {
      enable = mkEnableOption "networking";
    };
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;

    # https://github.com/NixOS/nixpkgs/issues/180175
    systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
    systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

    services.tailscale.enable = true;
  };
}
