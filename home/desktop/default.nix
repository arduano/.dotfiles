{ config, pkgs, inputs, ... }:

{
  imports = [ ./lmstudio.nix ./nvidia-sdk ];

  services.arduano.anydesk.enable = true;

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
