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
    ncdu
    nload
  ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
