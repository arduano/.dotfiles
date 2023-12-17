{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.anydesk ];
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
      ExecStart = "${pkgs.anydesk}/bin/anydesk";
      Restart = "on-abort";

      # Sandboxing.
      #   LockPersonality = true;
      #   MemoryDenyWriteExecute = true;
      #   NoNewPrivileges = true;
      #   PrivateUsers = true;
      #   RestrictNamespaces = true;
      #   SystemCallArchitectures = "native";
      #   SystemCallFilter = "@system-service";
    };
  };
}
