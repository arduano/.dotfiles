{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs.arduano.groups;
    build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming ++ gui-root ++ gui-root;

  arduano.shell.enable = true;
}
