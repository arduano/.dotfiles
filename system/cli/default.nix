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
  ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
