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
      description = "Optional power management config file";
    };
    arduano.kdeSetup.screenlockerFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Optional screen locker config file";
    };
  };

  config = mkIf cfg.enable (
    mkMerge [

      (lib.mkIf (cfg.powermanagementFile != null) {
        home.file.".config/powermanagementprofilesrc".source = cfg.powermanagementFile;
      })

      (lib.mkIf (cfg.screenlockerFile != null) { home.file.".config/kscreenlockerrc".source = cfg.screenlockerFile; })

      {
        services.kdeconnect.enable = true;
        services.kdeconnect.indicator = true;
      }
    ]);
}
