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
  arduano.tmux.enable = true;

  # Makera Studio remains installed in its isolated per-user prefix; Wine and
  # both launch paths are pinned by Nix. The legacy launcher is an immediate
  # rollback if the draft portal integration regresses.
  home.packages = [ pkgs.arduano.makera-studio ];
  home.file.".local/bin/makera-studio" = {
    source = "${pkgs.arduano.makera-studio}/bin/makera-studio";
    force = true;
  };
  home.file.".local/bin/makera-studio-legacy" = {
    source = "${pkgs.arduano.makera-studio}/bin/makera-studio-legacy";
    force = true;
  };

  # Keep the OAuth protocol handler and Plasma launcher under Home Manager.
  # `xdg.desktopEntries` is inactive here because this profile intentionally
  # leaves `xdg.enable` off, so manage the one desktop file explicitly.
  home.file.".local/share/applications/makera-studio.desktop" = {
    force = true;
    text = ''
      [Desktop Entry]
      Type=Application
      Name=Makera Studio
      Comment=Makera Studio with native KDE portal file dialogs
      Exec=${pkgs.arduano.makera-studio}/bin/makera-studio %u
      Terminal=false
      Categories=Graphics;Engineering;
      MimeType=x-scheme-handler/makera-studio;
      StartupNotify=true
      StartupWMClass=makerastudio.exe
    '';
  };

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
