{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = [ pkgs.gparted ];
}
