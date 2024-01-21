{ config, pkgs, inputs, lib, ... }:

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
in {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  home.packages = with pkgs; [
    fishPlugins.fzf-fish
    fzf
    fishPlugins.grc
    grc
    fishPlugins.tide
    fishPlugins.bass
    anyNixShellFishPlugin

    kitty
    tdrop
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Noto" "FantasqueSansMono" ]; })
  ];

  home.activation = {
    copyFishVars = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      PATH=${pkgs.python3}/bin:$PATH
      $DRY_RUN_CMD python ${./inject_fish_vars.py} ${
        ./fish_variables
      } ~/.config/fish/fish_variables
    '';
  };
}
