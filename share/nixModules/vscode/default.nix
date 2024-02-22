{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.arduano.vscode-server;
in
{
  options = {
    arduano.vscode-server =
      {
        enable = mkEnableOption "enable vscode server";
      };
  };

  config = mkIf cfg.enable
    {
      services.vscode-server.enable = true;
    };
}
