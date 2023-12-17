{ config, pkgs, inputs, ... }:

{
  # imports = [ ./nvm ];
  imports = [ ./cargo-install.nix ./firedbg ];

  home.packages = with pkgs; [
    rustup
    python3
    patchelf
    gdb
    nixpkgs-fmt

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
