{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    gpp
    cmake
    pkg-config
    gnumake
    ninja
  ];
}
