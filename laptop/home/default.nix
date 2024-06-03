{ config, pkgs, inputs, ... }:

{
  imports = [ ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "arduano";
  home.homeDirectory = "/home/arduano";

  nixpkgs.config.allowUnfree = true;

  arduano.shell.enable = true;
  arduano.shell.enable-gui = true;
  arduano.mangohud.enable = true;
  arduano.programming.enable = true;
  arduano.kdeSetup.enable = true;
  arduano.anydesk.enable = true;

  services.vscode-server.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  ] ++ pkgs.arduano.groups.gui-user;


  home.sessionVariables = {
    # EDITOR = "code";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
