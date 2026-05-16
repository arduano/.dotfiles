{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.roles.desktop-main-pc;
in
{
  options.arduano.roles.desktop-main-pc.enable = mkEnableOption "main-pc desktop defaults";

  config = mkIf cfg.enable {
    arduano.roles.desktop-common.enable = true;

    # Current main-pc baseline: Plasma on Wayland, including SDDM's Wayland
    # greeter, with the NVIDIA open kernel module. Keep this host-specific while
    # the Wayland migration settles; laptop display policy intentionally lives in
    # a separate role.
    services = {
      xserver.videoDrivers = [ "nvidia" ];

      displayManager = {
        defaultSession = "plasma";
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
