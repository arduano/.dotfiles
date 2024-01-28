{ config, pkgs, inputs, ... }:

{
  imports = [ ./anydesk.nix ./discord.nix ./lmstudio.nix ./nvidia-sdk ];

  home.packages = with pkgs; [
    teams-for-linux
    slack
    google-chrome
    xfce.xfce4-screenshooter
    qpwgraph
    zoom-us
    gimp
    qalculate-qt

    arduano.p7zip-gui
  ];
}
