{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.arduano.mangohud;
in
{
  options = {
    arduano.mangohud.enable = mkEnableOption "enable mangohud";
  };

  config = mkIf cfg.enable
    {
      programs.mangohud = {
        enable = true;
        enableSessionWide = true;
      };
    };
}
