{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.shell;
in
{
  options = {
    arduano.shell =
      {
        enable = mkEnableOption "arduano's shell config";
      };
  };

  config =
    mkIf cfg.enable {
      users.defaultUserShell = pkgs.fish;
      programs.fish.enable = true;
    };
}
