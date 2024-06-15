{ config, pkgs, inputs, ... }:
{
  home.file."${config.home.homeDirectory}/.config/hypr/hyprland.conf".source = ./configs/hyprland.conf;

  home.packages = with pkgs; [
    xdg-desktop-portal-hyprland
    polkit_gnome
    brightnessctl
    hyprshot
  ];

  services.mako = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };

  programs.wlogout = {
    enable = true;
  };

  programs.fuzzel = {
    enable = true;
  };

  services.network-manager-applet.enable = true;
}
