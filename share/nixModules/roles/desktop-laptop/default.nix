{ config, lib, ... }:

with lib;
let
  cfg = config.arduano.roles.desktop-laptop;
in
{
  options.arduano.roles.desktop-laptop.enable = mkEnableOption "laptop desktop defaults";

  config = mkIf cfg.enable {
    arduano.roles.desktop-common.enable = true;

    # Keep laptop display policy independent from main-pc NVIDIA tuning. The
    # Framework/AMD stack is already running Plasma Wayland without host-specific
    # NVIDIA options.
    services.displayManager.sddm.enable = true;
  };
}
