{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.services.arduano.anydesk;
in
{
  options = {
    services.arduano.anydesk =
      {
        enable = mkEnableOption "anydesk";

        package = mkOption {
          type = types.package;
          default = pkgs.anydesk;
        };
      };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    arduano.fixTrayTarget = true;

    systemd.user.services.anydesk = {
      Unit = {
        Description = "Remote desktop tool";
        Requires = [ "tray.target" ];
        After = [ "graphical-session-pre.target" "tray.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        Environment = "PATH=${config.home.profileDirectory}/bin";
        ExecStart = "${cfg.package}/bin/anydesk";
        Restart = "on-abort";
      };
    };
  };
}
