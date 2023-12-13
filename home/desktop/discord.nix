{ config, pkgs, inputs, lib, ... }:

let
  dvm = pkgs.rustPlatform.buildRustPackage rec {
    pname = "dvm";
    version = "1.1.9";

    src = pkgs.fetchFromGitHub {
      owner = "arduano";
      repo = pname;
      # rev = version;
      rev = "2bcf1ce";
      hash = "sha256-ObVMWpmI7S6nZlKWpzR5AylDIzw1S9XuaKeL1l3Cau0=";
    };

    cargoHash = "sha256-8Zjd+FT4GJ3ElZSp5FBZhscHEiZohYkmpWq+rtleY5A=";

    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = [ pkgs.openssl ];

    meta = with lib; {
      description =
        "A utility for managing versions of Discord, without waiting for Discord to be updated in nixpkgs";
      homepage = "https://github.com/diced/dvm";
      changelog = "https://github.com/diced/dvm/releases/tag/${version}";
      license = with licenses;
        [
          # The project doesn't specify a license
        ];
      maintainers = with maintainers;
        [
          # TODO: Add myself
        ];
      mainProgram = "dvm";
    };
  };
in { 
  # home.packages = [ dvm pkgs.discord ];
  home.packages = [ pkgs.discord ];
}
