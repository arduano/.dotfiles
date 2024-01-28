{
  # The description of the flake. Can be anything.
  description = "My first flake!";

  # The inputs of the flake, usually some git repositories, e.g. `nixpkgs`
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    arduano-modules = {
      url = "git+file:./share";
    };

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

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  # The output is your built and working system configuration
  outputs = { self, nixpkgs, nixos-hardware, arduano-modules, ... }@inputs:
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

    in
    {
      nixosConfigurations = {
        main-pc = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            programs-sqlite-db =
              flake-programs-sqlite.packages.${system}.programs-sqlite;
          };
          modules = [
            ./system
            nix-flatpak.nixosModules.nix-flatpak
            flake-programs-sqlite.nixosModules.programs-sqlite
            vscode-server.nixosModules.default

            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-pc-hdd
            nixos-hardware.nixosModules.common-cpu-amd

            arduano-modules.nixosModules
          ];
        };
      };
      homeConfigurations = {
        arduano = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs;
            inherit runtimePath;
            inherit fenix;
          };
          modules = [
            ./home
            plasma-manager.homeManagerModules.plasma-manager
            nix-flatpak.homeManagerModules.nix-flatpak

            arduano-modules.homeModules
          ];
        };
      };
    };
}
