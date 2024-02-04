{ config, pkgs, inputs, ... }:

{
  imports = [ ./lmstudio.nix ];

  services.arduano.anydesk.enable = true;

  home.packages = with pkgs; [
    teams-for-linux
    slack
    google-chrome
    xfce.xfce4-screenshooter
    easyocr
    qpwgraph
    zoom-us
    gimp
    qalculate-qt

    ollama

    arduano.p7zip-gui
  ];
}
