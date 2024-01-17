{ config, pkgs, inputs, ... }:

{
  imports = [
    ./build-essentials.nix
  ];

  environment.systemPackages = with pkgs; [
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
    imagemagick
    desktop-file-utils
    p7zip
    pv
    nix-du
    distrobox
    usbutils
  ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
