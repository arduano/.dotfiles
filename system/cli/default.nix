{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    ripgrep
    nload
    neofetch
    fastfetch
    htop
    tmux
    git
    gcc
    ncdu
    nload
    imagemagick
    desktop-file-utils
  ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
