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


  makeExtraPathConfig = { extra-path }:
    let
      # Map the extra-path array to fish_add_path calls
      extraPathsConfigStr = lib.concatStringsSep "\n" (lib.map (path: "fish_add_path -P ${path}") extra-path);
      extraPathFishConfig = pkgs.writeText "extra-path.fish" ''
        ${extraPathsConfigStr}
      '';

      extraPathFishConfigPluginSrc = pkgs.runCommand "extra-path-fish" { } ''
        mkdir -p $out/conf.d
        cp ${extraPathFishConfig} $out/conf.d/extra-path.fish
      '';
    in
    extraPathFishConfigPluginSrc;

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
        extra-path = mkOption {
          type = types.listOf types.str;
          default = [ ];
          description = "Extra paths to add to $PATH";
        };
      };
  };

  config =
    let
      shellConfig = mkIf cfg.enable {
        programs.fish = {
          enable = true;
        };

        programs.zoxide.enable = true;

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
          (makeExtraPathConfig { extra-path = cfg.extra-path; })
        ];
      };

      guiConfig = mkIf cfg.enable-gui {
        home.packages = with pkgs; [
          tdrop
          nerd-fonts.fira-code
          nerd-fonts.droid-sans-mono
          nerd-fonts.noto
          nerd-fonts.fantasque-sans-mono
          nerd-fonts.symbols-only
        ];

        programs.kitty = {
          enable = true;
          settings = {
            term = "xterm-256color";
            scrollback_lines = 10000;
            confirm_os_window_close = 0;
            font = "NotoMono NFM";
          };
        };
      };
    in
    mkMerge [ shellConfig guiConfig ];
}
