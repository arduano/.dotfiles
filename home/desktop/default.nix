{ config, pkgs, inputs, ... }:

{
  imports = [ ./anydesk.nix ./discord.nix ];

  home.packages = with pkgs; [ teams-for-linux slack google-chrome ];
}
