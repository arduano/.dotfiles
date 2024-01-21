{ config, pkgs, inputs, ... }:

{
  # imports = [ ./nvm ];
  imports = [ ./cargo-install.nix ./firedbg ];

  home.packages = with pkgs; [
    rustup
    patchelf
    gdb
    nixpkgs-fmt
    lldb

    (python3.override { x11Support = true; })
    python311Packages.tkinter

    nodejs_20
    nodePackages.yarn
    (import ./graphite {
      inherit pkgs; nodejs = nodejs_20;
    })."@withgraphite/graphite-cli-1.1.2"

    minicom

    (pkgs.writeShellScriptBin "fixfmt" ''
      git add . && cargo fix --workspace --allow-staged && cargo fmt --all
    '')
  ];

  programs.git = {
    enable = true;
    userName = "arduano";
    userEmail = "leonid.shchurov@gmail.com";
    extraConfig = {
      pull.rebase = "false";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
