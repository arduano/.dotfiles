{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs.arduano.groups;
    build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming ++ gui-useful;

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
