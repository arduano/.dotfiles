{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.desktopApps;
in
{
  options.arduano.desktopApps.enable = mkEnableOption "desktop application package set";

  config = mkIf cfg.enable {
    home.packages = pkgs.arduano.groups.gui-user;
  };
}
