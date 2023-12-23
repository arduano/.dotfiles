{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [ gparted xdg-desktop-portal ];
}
