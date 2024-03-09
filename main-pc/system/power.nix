{ config, pkgs, inputs, ... }:

{
  services.xserver.xautolock.enable = false;
  services.xserver.xautolock.time = 99999999;
  services.logind.powerKey = "suspend";
}
