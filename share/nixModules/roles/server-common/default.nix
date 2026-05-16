{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.roles.server-common;
in
{
  options.arduano.roles.server-common.enable = mkEnableOption "common server defaults";

  config = mkIf cfg.enable {
    arduano.networking.enable = true;
    arduano.shell.enable = true;
    arduano.locale.enable = true;

    environment.systemPackages = with pkgs.arduano.groups;
      build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming;

    virtualisation.docker.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
  };
}
