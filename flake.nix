{
  description = "Arduano's systems";

  # The inputs of the flake, usually some git repositories, e.g. `nixpkgs`
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager/trunk";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  # The output is your built and working system configuration
  outputs = { self, nixpkgs, nixos-hardware, vscode-server, flake-utils, ... }@inputs:
    with inputs;
    let
      systems = (import ./systems.nix) inputs;

      iso = flake-utils.lib.eachDefaultSystem (system:
        let
        in
        { }
      );

      packages = flake-utils.lib.eachDefaultSystem
        (system:
          let
            oldAttrs.version = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs;
              };
              modules = [ ./iso.nix ];
            };

            pkgs = import nixpkgs {
              inherit system;
              overlays = [ (import ./share/overlay.nix) ];
            };
          in
          {
            packages = pkgs.arduano // {
              baseIso = baseIso.config.system.build.isoImage;
            };
          }
        );

    in
    iso // packages // systems;
}
