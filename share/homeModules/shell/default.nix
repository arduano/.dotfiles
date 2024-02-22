{ config, lib, pkgs, ... }:

with lib;
let
  anyNixShellFishInit = pkgs.writeText "any-nix-shell.fish" ''
    ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
  '';

  anyNixShellFishPluginSrc = pkgs.runCommand "any-nix-shell-fish" { } ''
    mkdir -p $out/conf.d
    cp ${anyNixShellFishInit} $out/conf.d/any-nix-shell.fish
  '';

  anyNixShellFishPlugin = pkgs.fishPlugins.buildFishPlugin {
    pname = "any-nix-shell";
    version = "1.0.0";

    src = anyNixShellFishPluginSrc;

    meta = with lib; {
      description = "Fish plugin for any-nix-shell";
      license = licenses.mit;
      maintainers = with maintainers; [ ];
      platforms = with platforms; unix;
    };
  };

  varsInitFishPluginSrc = pkgs.runCommand "fish-vars-init" { } ''
    mkdir -p $out/conf.d
    cp ${./fish_variables.fish} $out/conf.d/fish_variables.fish
  '';

  varsInitFishPlugin = pkgs.fishPlugins.buildFishPlugin {
    pname = "fish-vars-init";
    version = "1.0.0";

    src = varsInitFishPluginSrc;
  };

  cfg = config.arduano.shell;
in
{
  options = {
    arduano.shell =
      {
        enable = mkEnableOption "arduano's shell config";
        enable-gui = mkEnableOption "arduano's terminal GUI config";
      };
  };

  config =
    let
      shellConfig = mkIf cfg.enable {
        programs.fish = {
          enable = true;
        };

        home.packages = with pkgs; [
          fishPlugins.fzf-fish
          fzf
          fd
          fishPlugins.grc
          grc
          fishPlugins.tide
          fishPlugins.bass
          anyNixShellFishPlugin
          varsInitFishPlugin
        ];
      };

      guiConfig = mkIf cfg.enable-gui {
        home.packages = with pkgs; [
          tdrop
          (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Noto" "FantasqueSansMono" ]; })
        ];

        programs.kitty = {
          enable = true;
          settings = {
            term = "xterm-256color";
            scrollback_lines = 10000;
            confirm_os_window_close = 0;
          };
        };
      };
    in
    mkMerge [ shellConfig guiConfig ];
}
