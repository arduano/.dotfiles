{ config, pkgs, inputs, ... }:

{
  # imports = [ ./nvm ];

  home.packages = with pkgs; [
    rustup
    python3
    patchelf
    gdb
    nixpkgs-fmt
  ];

  programs.git = {
    enable = true;
    userName = "arduano";
    userEmail = "leonid.shchurov@gmail.com";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
