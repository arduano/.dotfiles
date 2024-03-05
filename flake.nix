{
  # The description of the flake. Can be anything.
  description = "My first flake!";

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

    nix-flatpak.url = "github:gmodena/nix-flatpak";

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
      lib = nixpkgs.lib;

      commonSystemModules = [
        nix-flatpak.nixosModules.nix-flatpak
        inputs.home-manager.nixosModules.home-manager
        (import ./share/nixModules)
        (import ./share/overlayModule.nix)

        # TODO: https://github.com/wamserma/flake-programs-sqlite
        flake-programs-sqlite.nixosModules.programs-sqlite
      ];

      commonHomeModules = [
        nix-flatpak.homeManagerModules.nix-flatpak
        vscode-server.homeModules.default
        (import ./share/homeModules)
        (import ./share/overlayModule.nix)
      ];

      makeSystem = { systemModules ? [ ], homeModules ? [ ], extraArgs ? { }, system ? "x86_64-linux" }:
        lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = extraArgs // {
            inherit inputs;
          };
          modules = commonSystemModules ++ systemModules ++ [{
            home-manager.users.arduano = {
              imports = commonHomeModules ++ homeModules;
            };
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }];
        };

      # systems = {
      #   nixosConfigurations.main-pc = makeSystem {
      #     systemModules = [
      #       ./main-pc/system
      #       nixos-hardware.nixosModules.common-pc
      #       nixos-hardware.nixosModules.common-pc-ssd
      #       nixos-hardware.nixosModules.common-pc-hdd
      #       nixos-hardware.nixosModules.common-cpu-amd
      #     ];
      #     homeModules = [
      #       ./main-pc/home
      #       plasma-manager.homeManagerModules.plasma-manager
      #     ];
      #   };
      # };

      systems = (import ./systems.nix) inputs;

          packages= flake-utils. lib. eachDefaultSystem
          ( system:
        let
          pkgs= import nixpkgs{
        inherit system;
        overlays = [ (import ./share/overlay.nix) ];
      };
    in
    {
      packages = pkgs.arduano;
    }
    );

  in
  packages // systems;
  }
