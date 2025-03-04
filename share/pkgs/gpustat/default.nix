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
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "arduano";
    repo = "gpustat";
    rev = "v${version}";
    sha256 = "sha256-M9P/qfw/tp9ogkNOE3b2fD2rGFnii1/VwmqJHqXb7Mg=";
  };

  cargoHash = "sha256-po/pEMZEtySZnz7l2FI7Wqbmp2CiWBijchKGkqlIMPU=";

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

  postInstall = ''
    mkdir -p $out/share/applications $out/share/pixmaps

    cp assets/gpustat.desktop $out/share/applications
    cp assets/gpustat_icon_* $out/share/pixmaps
  '';

  # Wrap the program in a script that sets the LD_LIBRARY_PATH environment variable
  # so that it can find the shared libraries it depends on.
  postFixup = ''
    wrapProgram $out/bin/gpustat --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}:/run/opengl-driver/lib"
  '';

  meta = with lib; {
    # description = "A utility that combines the usability of The Silver Searcher with the raw speed of grep";
    # homepage = "https://github.com/BurntSushi/ripgrep";
    # license = with licenses; [ unlicense /* or */ mit ];
    # maintainers = with maintainers; [ globin ma27 zowoq ];
    mainProgram = "gpustat";
  };
}
