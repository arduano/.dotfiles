{ config, pkgs, inputs, fenix, lib, ... }:

let
  stable-2023-12-04 = fenix.packages.${pkgs.system}.fromToolchainName {
    name = "stable";
    sha256 = "sha256-PjvuouwTsYfNKW5Vi5Ye7y+lL7SsWGBxCtBOOm2z14c=";
  };

  makeRustPlatform = pkgs.makeRustPlatform.override {
    stdenv = pkgs.clangStdenv; # Nope
    buildPackages = pkgs.buildPackages // { stdenv = pkgs.clangStdenv; }; # Nope
  };

  toolchain = stable-2023-12-04.toolchain.override {
    stdenv = pkgs.clangStdenv;
    buildPackages = pkgs.buildPackages // { stdenv = pkgs.clangStdenv; };
  };

  rustPlatform-stable-2023-12-04 = makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
    stdenv = pkgs.clangStdenv; # Nope
  };

  pkgs' = pkgs.extend (self: super: {
    rust = super.rust.override {
      stdenv = pkgs.clangStdenv;
      buildPackages = pkgs.buildPackages // { stdenv = pkgs.clangStdenv; };
    };
  });

  firedbg = pkgs'.rustPlatform.buildRustPackage rec {
    pname = "firedbg";
    version = "1.74.2";

    src = pkgs.fetchFromGitHub {
      owner = "SeaQL";
      repo = "FireDBG.for.Rust";
      rev = version;
      hash = "sha256-Hx8yWLUrbae8fLyHRka2h7k2G3BP3ERzNkxyDmMfziA=";
    };

    postPatch = ''
      ln -s ${./Cargo.lock} Cargo.lock
    '';

    # cargoHash = "sha256-8Zjd+FT4GJ3ElZSp5FBZhscHEiZohYkmpWq+rtleY5A=";
    cargoLock = {
      lockFile = ./Cargo.lock;
    };

    depsBuildBuild = [
      pkgs.clang_14
    ];
    nativeBuildInputs = [ pkgs.pkg-config pkgs.clang_14 ];
    buildInputs = [ pkgs.openssl pkgs.lldb pkgs.libcxx pkgs.libcxxabi ];

    doCheck = false;

    meta = with lib; {
      description =
        "🔥 Time Travel Visual Debugger for Rust";
      homepage = "https://firedbg.sea-ql.org/";
      changelog = "https://github.com/SeaQL/FireDBG.for.Rust/releases/tag/${version}";
      license = with licenses;
        [
          mit
        ];
      maintainers = with maintainers;
        [
          # TODO: Add myself
        ];
      mainProgram = "dvm";
    };
  };

in
{
  # home.packages = [ dvm pkgs.discord ];
  home.packages = [ firedbg ];
}
