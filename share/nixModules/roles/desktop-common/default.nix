{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.roles.desktop-common;
in
{
  options.arduano.roles.desktop-common.enable = mkEnableOption "common desktop defaults";

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        xkb.layout = "us";
      };

      desktopManager.plasma6.enable = true;
      printing.enable = true;

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };

      avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
          workstation = true;
        };
      };
    };

    security.rtkit.enable = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };

    environment.systemPackages = with pkgs; [
      kdePackages.sddm-kcm
      xdg-desktop-portal
    ];
  };
}
