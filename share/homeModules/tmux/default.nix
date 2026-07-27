{ config, lib, ... }:

with lib;
let
  cfg = config.arduano.tmux;
in
{
  options.arduano.tmux.enable = mkEnableOption "arduano's tmux configuration";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      mouse = true;
      extraConfig = ''
        # Enter copy/scroll mode with Alt-Up (no tmux prefix required).
        bind -n M-Up copy-mode
      '';
    };
  };
}
