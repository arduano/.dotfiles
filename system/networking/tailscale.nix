{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = [ pkgs.tailscale ];
  services.tailscale.enable = true;
}
