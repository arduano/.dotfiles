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
      system = "x86_64-linux";

      runtimeRoot = "/home/arduano/.dotfiles";
      runtimePath = path:
        let
          # This is the `self` that gets passed to a flake `outputs`.
          rootStr = toString self;
          pathStr = toString path;
        in
        assert lib.assertMsg (lib.hasPrefix rootStr pathStr)
          "${pathStr} does not start with ${rootStr}";
        runtimeRoot + (lib.removePrefix rootStr pathStr);

      systems =
        {
          nixosConfigurations = {
            main-pc = lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs;
                inherit runtimePath;
              };
              modules = [
                ./system
                nix-flatpak.nixosModules.nix-flatpak

                # TODO: https://github.com/wamserma/flake-programs-sqlite
                flake-programs-sqlite.nixosModules.programs-sqlite

                nixos-hardware.nixosModules.common-pc
                nixos-hardware.nixosModules.common-pc-ssd
                nixos-hardware.nixosModules.common-pc-hdd
                nixos-hardware.nixosModules.common-cpu-amd

                inputs.home-manager.nixosModules.home-manager
                {
                  home-manager.users.arduano =
                    {
                      imports = [
                        ./home
                        plasma-manager.homeManagerModules.plasma-manager
                        nix-flatpak.homeManagerModules.nix-flatpak

                        (import ./share/homeModules)
                        (import ./share/overlayModule.nix)
                      ];
                    };
                  home-manager.extraSpecialArgs = {
                    inherit inputs;
                    inherit runtimePath;
                  };
                }

                (import ./share/nixModules)
                (import ./share/overlayModule.nix)
                vscode-server.nixosModules.default
              ];
            };
          };
        };


      packages = flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = import nixpkgs {
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
