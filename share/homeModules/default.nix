{ config, lib, pkgs, ... }: {
  imports = [
    ./anydesk
    ./shell
    ./trayTargetFix
    ./mangohud
    ./programming
    ./kdeSetup
  ];
}
