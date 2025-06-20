{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.arduano.kdeSetup;
in
{
  options = {
    arduano.kdeSetup.enable = mkEnableOption "Enable the kde setup";
    arduano.kdeSetup.powermanagementFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Enable power management fike";
    };
    arduano.kdeSetup.screenlockerFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Enable screen locker fike";
    };
  };

  config = mkIf cfg.enable (
    mkMerge [

      (lib.mkIf (cfg.powermanagementFile != null) {
        home.file.".config/powermanagementprofilesrc".source = cfg.powermanagementFile; })

      (lib.mkIf (cfg.screenlockerFile != null)  { home.file.".config/kscreenlockerrc".source = cfg.screenlockerFile; })

      {
      services.kdeconnect.enable = true;
      services.kdeconnect.indicator = true;

      # TODO: Plasma config. Run `nix run github:pjones/plasma-manager` for your current full config.
      # For more docs, visit https://github.com/pjones/plasma-manager
      programs.plasma = {
        enable = true;

        workspace = {
          clickItemTo = "select";
          theme = "breeze-dark";
          colorScheme = "BreezeDark";
        };

        # Updating these may require a session restart
        shortcuts = {
          kwin."Window Quick Tile Top" = [ ];
          kwin."Window Quick Tile Bottom" = [ ];
          kwin."Window Maximize" = "Meta+Up";
          kwin."Window Minimize" = "Meta+Down";

          # I use flameshot instead
          # "org.kde.spectacle.desktop"."ActiveWindowScreenShot" = [ ];
          # "org.kde.spectacle.desktop"."CurrentMonitorScreenShot" = [ ];
          # "org.kde.spectacle.desktop"."FullScreenScreenShot" = [ ];
          # "org.kde.spectacle.desktop"."OpenWithoutScreenshot" = [ ];
          # "org.kde.spectacle.desktop"."RectangularRegionScreenShot" = [ ];
          # "org.kde.spectacle.desktop"."WindowUnderCursorScreenShot" = [ ];

          "org.kde.spectacle.desktop"."_launch" = [ ];
          "org.kde.konsole.desktop"."_launch" = [ ];
        };

        configFile = {
          kwinrulesrc = {
            # `rules` is a comma separated list of the properties
            General = { rules.value = "anydesk"; };

            anydesk = {
              Description.value = "Window settings for anydesk";
              clientmachine.value = "localhost";
              minimize.value = true;
              minimizerule.value = 3;
              title.value = "AnyDesk";
              titlematch.value = 1;
              types.value = 1;
              windowrole.value = "MainWindow#1";
              wmclass.value = "anydesk";
              wmclassmatch.value = 1;
            };
          };

          ksmserverrc.General.loginMode.value = "emptySession";

          kdeglobals = {
            General.TerminalApplication.value = "konsole";
            General.TerminalService.value = "konsole.desktop";
          };
        };
      };
    }
  ]);
}
