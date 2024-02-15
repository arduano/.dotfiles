{ config, pkgs, inputs, ... }:

with pkgs;
let
  essentials = [
    vim
    wget
    curl
    ripgrep
    nload
    neofetch
    fastfetch
    pciutils
    htop
    tmux
    git
    ncdu
    nload
    pv
    jq
    usbutils
    nmap
    xz
  ];

  useful = [
    imagemagick
    p7zip
    nix-du
    ffmpeg
  ];

  others = [
    distrobox
  ];

in
{
  imports = [
    ./build-essentials.nix
  ];

  environment.systemPackages = essentials ++ useful ++ others;

  users.defaultUserShell = fish;
  programs.fish.enable = true;
}
