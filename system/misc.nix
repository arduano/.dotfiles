{ config, pkgs, inputs, ... }:

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
  environment.systemPackages = with pkgs; [ xdg-desktop-portal ];
}
