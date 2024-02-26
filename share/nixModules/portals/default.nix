{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.portals;
in
{
  options = {
    arduano.portals =
      {
        enable = mkEnableOption "XDG portals";
      };
  };

  config =
    mkIf cfg.enable {
      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
      };
      environment.systemPackages = with pkgs; [ xdg-desktop-portal ];
    };
}
