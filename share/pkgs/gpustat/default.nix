{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, asciidoctor
, installShellFiles
, pkg-config
, Security
, withPCRE2 ? true
, pcre2
}:

rustPlatform.buildRustPackage rec {
  pname = "gpustat";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "arduano";
    repo = pname;
    rev = version;
    sha256 = "";
  };

  cargoSha256 = "";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    fontconfig

    libGL
    libxkbcommon
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];

  meta = with lib; {
    # description = "A utility that combines the usability of The Silver Searcher with the raw speed of grep";
    # homepage = "https://github.com/BurntSushi/ripgrep";
    # license = with licenses; [ unlicense /* or */ mit ];
    # maintainers = with maintainers; [ globin ma27 zowoq ];
    mainProgram = "gpustat";
  };
}
