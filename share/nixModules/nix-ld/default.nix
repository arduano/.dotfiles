{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.nix-ld;
in
{
  options = {
    arduano.nix-ld = {
      enable = mkEnableOption "Nix Ld";
    };
  };

  config = mkIf cfg.enable {
  # Enable nix ld
  programs.nix-ld.enable = true;

  # Sets up all the libraries to load
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];
  };
}
