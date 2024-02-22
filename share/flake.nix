{
  description = "Arduano's overrides";

  inputs = {
    nixpkgs.url = "nixpkgs";

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # The output is your built and working system configuration
  outputs = { self, vscode-server, flake-utils, nixpkgs, ... }@inputs:
    let
      overlay = {
        nixpkgs.overlays = [
          (import ./overlay.nix)
        ];
      };

      # Modules for consuming this flake in a NixOS system
      modules = {
        nixosModules = _: {
          imports = [
            ./nixModules
            vscode-server.nixosModules.default
            overlay
          ];
        };

        homeModules = _: {
          imports = [
            ./homeModules
            overlay
          ];
        };

        overlay = import ./overlay.nix;
      };

      # Packages for running directly from this flake via `nix run`
      packages = flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ (import ./overlay.nix) ];
            };
          in
          {
            packages = pkgs.arduano;
          }
        );
    in
    packages // modules;
}
