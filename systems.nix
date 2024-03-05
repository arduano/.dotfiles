inputs:
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
in

{
  nixosConfigurations.main-pc = makeSystem {
    systemModules = [
      ./main-pc/system
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd
      nixos-hardware.nixosModules.common-pc-hdd
      nixos-hardware.nixosModules.common-cpu-amd
    ];
    homeModules = [
      ./main-pc/home
      plasma-manager.homeManagerModules.plasma-manager
    ];
  };

  nixosConfigurations.home-nas = makeSystem {
    systemModules = [
      ./home-nas/system
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd
      nixos-hardware.nixosModules.common-pc-hdd
      nixos-hardware.nixosModules.common-cpu-intel
    ];
    homeModules = [
      ./home-nas/home
    ];
  };
}
