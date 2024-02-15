{ config, pkgs, inputs, ... }:

let
  nodepkgs = (import ./node {
    inherit pkgs; nodejs = pkgs.nodejs_20;
  });
in

{
  imports = [
    ./cargo-install.nix
    ./firedbg
  ];

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
    nodepkgs."@withgraphite/graphite-cli"
    nodepkgs."@marp-team/marp-cli"

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
