{ config, lib, pkgs, inputs, ... }:

let
  pcLockMqtt = pkgs.writeShellApplication {
    name = "pc-lock-mqtt";
    runtimeInputs = with pkgs; [
      nodejs_24
      kdePackages.qttools
    ];
    text = ''
      exec node ${./pc-lock-mqtt.js}
    '';
  };
in

{
  imports = [ ];

  home.username = "arduano";
  home.homeDirectory = "/home/arduano";

  nixpkgs.config.allowUnfree = true;

  arduano.shell.enable = true;
  arduano.shell.enable-gui = true;
  arduano.desktopApps.enable = true;
  arduano.mangohud.enable = true;
  arduano.programming.enable = true;

  arduano.kdeSetup.enable = true;

  systemd.user.services.pc-lock-mqtt = {
    Unit = {
      Description = "MQTT listener for locking the KDE session";
      After = [ "network-online.target" "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pcLockMqtt}/bin/pc-lock-mqtt";
      Restart = "always";
      RestartSec = 10;

      # Override these with `systemctl --user edit pc-lock-mqtt.service` if the
      # broker/topic changes. Defaults match the Home Assistant automation plan.
      Environment = [
        "MQTT_HOST=home-nas"
        "MQTT_PORT=1883"
        "MQTT_TOPIC=home/main-pc/lock/set"
        "MQTT_STATUS_TOPIC=home/main-pc/lock/status"
      ];
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
