{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, pkg-config
, fontconfig
, libGL
, xorg
, cmake
, libxkbcommon
, wayland
, makeWrapper
}:

rustPlatform.buildRustPackage rec {
  pname = "gpustat";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "arduano";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-NvX6IDzjCJrj41qzSGDiHN74Og2gw4sodRSWYLfwr14=";
  };

  cargoSha256 = "sha256-LwA0pOUBchXOhejv59ogs8rH5VuwiWY6JlNjjdiyJTE=";

  nativeBuildInputs = [ pkg-config cmake makeWrapper ];
  buildInputs = [
    fontconfig
    libGL
    libxkbcommon
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    wayland
  ];

  # Wrap the program in a script that sets the LD_LIBRARY_PATH environment variable
  # so that it can find the shared libraries it depends on.
  postFixup = ''
    wrapProgram $out/bin/gpustat --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}
  '';

  meta = with lib; {
    # description = "A utility that combines the usability of The Silver Searcher with the raw speed of grep";
    # homepage = "https://github.com/BurntSushi/ripgrep";
    # license = with licenses; [ unlicense /* or */ mit ];
    # maintainers = with maintainers; [ globin ma27 zowoq ];
    mainProgram = "gpustat";
  };
}
