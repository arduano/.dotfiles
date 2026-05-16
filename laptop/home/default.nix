{ config, pkgs, inputs, ... }:

{
  imports = [ ];

  home.username = "arduano";
  home.homeDirectory = "/home/arduano";

  nixpkgs.config.allowUnfree = true;

  arduano.shell.enable = true;
  arduano.shell.enable-gui = true;
  arduano.desktopApps.enable = true;
  arduano.mangohud.enable = true;
  arduano.programming.enable = true;

  arduano.kdeSetup.enable = true;

  services.vscode-server.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
