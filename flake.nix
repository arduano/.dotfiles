{
  description = "Arduano's systems";

  nixConfig = {
    extra-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  # The inputs of the flake, usually some git repositories, e.g. `nixpkgs`
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Kept separate so OpenClaw can use a SQLite-safe Node release without
    # forcing every system onto a newer nixpkgs revision.
    nixpkgs-openclaw-runtime.url = "github:NixOS/nixpkgs/18b9261cb3294b6d2a06d03f96872827b8fe2698";

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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-openclaw.url = "github:openclaw/nix-openclaw";


    flake-utils.url = "github:numtide/flake-utils";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Maintained Raspberry Pi kernel, firmware and generational boot support.
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/v1.20260801.0";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # The output is your built and working system configuration
  outputs = { self, nixpkgs, nixos-hardware, vscode-server, flake-utils, ... }@inputs:
    with inputs;
    let
      systems = (import ./systems.nix) inputs;

      packages = flake-utils.lib.eachSystem [ "x86_64-linux" ]
        (system:
          let
            baseIso = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs;
              };
              modules = [ ./iso.nix ];
            };

            baseGuiIso = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs;
              };
              modules = [ ./iso-gui.nix ];
            };

            universalRecoveryIso = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs;
              };
              modules = [ ./iso-universal-recovery.nix ];
            };

            pkgs = import nixpkgs {
              inherit system;
              overlays = [ (import ./share/overlay.nix { inherit inputs; }) ];
            };

            arduanoPackages = nixpkgs.lib.filterAttrs (_: nixpkgs.lib.isDerivation) pkgs.arduano;
          in
          {
            packages = arduanoPackages // {
              baseIso = baseIso.config.system.build.isoImage;
              baseGuiIso = baseGuiIso.config.system.build.isoImage;
              universalRecoveryIso = universalRecoveryIso.config.system.build.isoImage;
            };
          }
        );

    in
    packages // systems;
}
