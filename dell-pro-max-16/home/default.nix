{ ... }:

{
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

  home.stateVersion = "26.11";
}
