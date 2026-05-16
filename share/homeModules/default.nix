{ config, lib, pkgs, ... }: {
  imports = [
    ./shell
    ./mangohud
    ./programming
    ./kdeSetup
    ./desktopApps
  ];
}
