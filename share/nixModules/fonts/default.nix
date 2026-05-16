{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.fonts;
in
{
  options = {
    arduano.fonts = {
      enable = mkEnableOption "fonts configuration";
    };
  };

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        # Optional alternatives:
        # source-han-sans
        # source-han-serif
        # ipaexfont
      ];

      # Optional, but makes fallback deterministic:
      fontconfig.defaultFonts = {
        sansSerif = [ "Noto Sans" "Noto Sans CJK JP" ];
        serif = [ "Noto Serif" "Noto Serif CJK JP" ];
        monospace = [ "Noto Sans Mono" "Noto Sans Mono CJK JP" ];
      };
    };
  };
}
