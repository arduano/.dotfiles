{ config, pkgs, inputs, ... }:

{
  imports = [ ./anydesk.nix ./discord.nix ];

  home.packages = with pkgs; [
    teams-for-linux
    slack
    google-chrome
    xfce.xfce4-screenshooter
    qpwgraph
  ];
}
