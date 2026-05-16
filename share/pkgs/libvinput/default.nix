{ lib
, stdenv
, fetchFromGitHub
, clang
, clang-tools
, gnumake
, pkg-config
, xdo
, xdotool
, libx11
, libxi
, libxcb
, libxtst
, xinput
, libevdev
, libxkbcommon
}:

stdenv.mkDerivation rec {
  pname = "libvinput";
  version = "1.2.3";

  src = fetchFromGitHub {
    owner = "slendidev";
    repo = "libvinput";
    rev = "v${version}";
    sha256 = "03wkrppws34rz4i7aibz0250pavj34cw00ypjw6x6fihdi2mlyjb";
  };

  nativeBuildInputs = [ clang clang-tools gnumake pkg-config ];
  buildInputs = [
    xdo
    xdotool
    libxtst
    libx11
    libxcb
    xinput
    libxi
    libevdev
    libxkbcommon
  ];

  makeFlags = [ "CC=clang" ];

  buildPhase = "make";

  installPhase = ''
    mkdir -p $out/lib $out/lib/pkgconfig
    cp libvinput.so* $out/lib/
    if [ -f libvinput.pc ]; then
      cp libvinput.pc $out/lib/pkgconfig/
    fi
  '';

  meta = with lib; {
    description = "Cross-platform simple keyboard hook/emulator library (libvinput)";
    homepage = "https://github.com/slendidev/libvinput";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
