{ config, pkgs, inputs, lib, ... }:

let
  lmstudio = with pkgs; appimageTools.wrapType2 {
    name = "lmstudio";
    src = fetchurl {
      url = "https://s3.amazonaws.com/releases.lmstudio.ai/prerelease/LM+Studio-0.2.8-beta-v1.AppImage";
      hash = "sha256-Ha1G9YrLrHBPYHoqOoMhqVr/9AtUQILCuxdp07kWebk=";
    };
    extraPkgs = pkgs: with pkgs; [ ];
  };
in
{
  home.packages = [ lmstudio ];
}
