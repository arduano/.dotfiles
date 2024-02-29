{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.arduano.kdeSetup;
in
{
  options = {
    arduano.kdeSetup.enable = mkEnableOption "Enable the kde setup";
  };

  config = mkIf cfg.enable {
    services.kdeconnect.enable = true;
    services.kdeconnect.indicator = true;

    home.file.".config/powermanagementprofilesrc".source = ./powermanagementprofilesrc;
    home.file.".config/kscreenlockerrc".source = ./kscreenlockerrc;

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
        "org.kde.spectacle.desktop"."ActiveWindowScreenShot" = [ ];
        "org.kde.spectacle.desktop"."CurrentMonitorScreenShot" = [ ];
        "org.kde.spectacle.desktop"."FullScreenScreenShot" = [ ];
        "org.kde.spectacle.desktop"."OpenWithoutScreenshot" = [ ];
        "org.kde.spectacle.desktop"."RectangularRegionScreenShot" = [ ];
        "org.kde.spectacle.desktop"."WindowUnderCursorScreenShot" = [ ];

        "org.kde.spectacle.desktop"."_launch" = [ ];
        "org.kde.konsole.desktop"."_launch" = [ ];
      };

      # Hotkeys don't seem to reliably work
      hotkeys.commands = {
        # tdrop = {
        #   command = ''tdrop -ma kitty'';
        #   name = "Dropdown Terminal";
        #   key = "Ctrl+`";
        # };

        # flameshot = {
        #   command = "flameshot gui";
        #   name = "Flameshot";
        #   key = "Print";
        # };
      };

      configFile = {
        kwinrulesrc = {
          # `rules` is a comma separated list of the properties
          General = { rules = "anydesk"; };

          anydesk = {
            Description = "Window settings for anydesk";
            clientmachine = "localhost";
            minimize = true;
            minimizerule = 3;
            title = "AnyDesk";
            titlematch = 1;
            types = 1;
            windowrole = "MainWindow#1";
            wmclass = "anydesk";
            wmclassmatch = 1;
          };
        };

        ksmserverrc.General.loginMode = "emptySession";

        kdeglobals = {
          General.TerminalApplication = "kitty";
          General.TerminalService = "kitty.desktop";
        };
      };
    };
  };
}
