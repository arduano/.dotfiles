{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.tmux;
in
{
  options.arduano.tmux.enable = mkEnableOption "arduano's tmux configuration";

  config = mkIf cfg.enable {
    # Ghostty's main package and terminfo database are separate Nix outputs.
    # The latter is required on SSH targets before tmux can interpret an
    # incoming TERM=xterm-ghostty session.
    home.packages = [ pkgs.ghostty.terminfo ];

    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      mouse = true;
      extraConfig = ''
        # Enter copy/scroll mode with Alt-Up (no tmux prefix required).
        bind -n M-Up copy-mode
      '';
    };
  };
}
