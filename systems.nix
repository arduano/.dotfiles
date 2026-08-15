inputs:
with inputs;
let
  lib = nixpkgs.lib;

  commonSystemModules = [
    inputs.home-manager.nixosModules.home-manager
    (import ./share/nixModules)
    (import ./share/overlayModule.nix)

    # TODO: https://github.com/wamserma/flake-programs-sqlite
    # flake-programs-sqlite.nixosModules.programs-sqlite
  ];

  commonHomeModules = [
    vscode-server.homeModules.default
    plasma-manager.homeModules.plasma-manager
    nix-openclaw.homeManagerModules.openclaw
    (import ./share/homeModules)
    (import ./share/overlayModule.nix)
  ];

  makeSystem = { systemModules ? [ ], homeModules ? [ ], extraArgs ? { }, system ? "x86_64-linux" }:
    lib.nixosSystem {
      inherit system;
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
      nixos-hardware.nixosModules.common-cpu-amd
    ];
    homeModules = [
      ./main-pc/home
    ];
  };

  nixosConfigurations.laptop = makeSystem {
    systemModules = [
      ./laptop/system
      nixos-hardware.nixosModules.framework-16-7040-amd
    ];
    homeModules = [
      ./laptop/home
    ];
  };

  nixosConfigurations.home-nas = makeSystem {
    systemModules = [
      ./home-nas/system
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd
      nixos-hardware.nixosModules.common-cpu-intel
    ];
    homeModules = [
      ./home-nas/home
    ];
  };

  nixosConfigurations.kiosk-laptop-1 = makeSystem {
    systemModules = [
      ./kiosk-laptop-1/system
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd
      nixos-hardware.nixosModules.common-cpu-intel
    ];
    homeModules = [
      ./kiosk-laptop-1/home
    ];
  };

  nixosConfigurations.rpi5-test = nixos-raspberrypi.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      disko.nixosModules.disko
      ./rpi5-test/system
    ];
  };
}
