{ pkgs, lib, config, ... }:

with lib;
let
  fixTrayTarget = config.arduano.fixTrayTarget;
in
{
  options = {
    arduano.fixTrayTarget = mkEnableOption "fix tray target";
  };

  config = mkIf fixTrayTarget
    {
      # TODO: https://github.com/nix-community/home-manager/issues/2064
      systemd.user.targets.tray = {
        Unit = {
          Description = "Home Manager System Tray";
          Requires = [ "graphical-session-pre.target" ];
        };
      };
    };
}
