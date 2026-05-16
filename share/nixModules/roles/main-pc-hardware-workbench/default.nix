{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.roles.main-pc-hardware-workbench;
in
{
  options.arduano.roles.main-pc-hardware-workbench.enable = mkEnableOption "main-pc hardware workbench tooling";

  config = mkIf cfg.enable {
    # Embedded hardware access for QMK-compatible devices.
    services.udev.packages = with pkgs; [
      qmk-udev-rules
    ];

    # Local embedded and fabrication utilities that need system integration.
    environment.systemPackages = with pkgs; [
      arduino-ide
      avrdude
      dfu-util
      esptool
      minicom
      openscad
      picocom
      platformio
      python3Packages.pyserial
      screen
    ];

    # Desktop slicer workflows.
    home-manager.users.arduano.home.packages = with pkgs; [
      arduano.snapmaker-orca-slicer
      arduano.snapmaker-orca-full-spectrum
    ];
  };
}
