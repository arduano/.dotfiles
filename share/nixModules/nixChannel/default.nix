{ pkgs, lib, config, ... }:

with lib;
let
  nixPath = "/run/nixPath";

  cfg = config.arduano.syncNixChannel;
in
{
  options = {
    arduano.syncNixChannel =
      {
        enable = mkEnableOption "nix channel syncing";
      };
  };

  config = mkIf cfg.enable
    {
      systemd.tmpfiles.rules = [
        "L+ ${nixPath} - - - - ${pkgs.path}"
      ];

      nix = {
        nixPath = [ "nixpkgs=${nixPath}" ];
      };
    };
}
