{ config, pkgs, inputs, fenix, system, ... }:

with pkgs;
let
  # nightly-2023-05-28 = fenix.packages.${pkgs.system}.fromToolchainName {
  #   name = "nightly-2023-05-28";
  #   sha256 = "sha256-QC8k/RoYy92ua6fDxRXqaefpEl28J7LL+6SIfkzWhZY=";
  # };

  # rustPlatform-nightly-2023-05-28 = makeRustPlatform {
  #   cargo = nightly-2023-05-28.toolchain;
  #   rustc = nightly-2023-05-28.toolchain;
  # };

  cargoInstall = { rustPlatform ? pkgs.rustPlatform, name, version, crateHash, depsHash, doCheck ? false }: rustPlatform.buildRustPackage
    rec {
      pname = name;
      inherit version;

      src = fetchCrate {
        inherit pname version;
        hash = crateHash;
      };

      inherit doCheck;

      cargoHash = depsHash;
      cargoDepsName = pname;
    };
in

{
  home.packages = [
    cargo-fuzz
    cargo-outdated
    cargo-audit
    cargo-license
    cargo-flamegraph
    # (cargoInstall {
    #   name = "";
    #   version = "0.11.2";
    #   crateHash = "sha256-iPfhXdpamzNJIQLezqeDZ7WFo/fKp54wOXcaJVBSZM4=";
    #   depsHash = "sha256-tncgw+AGAzt85M7x0VBpSzwWuXOnY4AREriYGzygNZA=";
    #   doCheck = false;
    # })
  ];

  nixpkgs.overlays = [ fenix.overlays.default ];
}
