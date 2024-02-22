{ stdenv, lib, fetchurl, cmake, pkg-config, gtk3, libGLU, gst_all_1, libmspack, libnotify, SDL2, webkitgtk, ... }:
stdenv.mkDerivation rec {
  pname = "wxwidgets-gtk3";
  version = "3.2.4";

  src = fetchurl {
    url = "https://github.com/wxWidgets/wxWidgets/releases/download/v${version}/wxWidgets-${version}.tar.bz2";
    sha256 = "0640e1ab716db5af2ecb7389dbef6138d7679261fbff730d23845ba838ca133e";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ gtk3 libGLU gst_all_1.gst-plugins-bad libmspack libnotify SDL2 webkitgtk ];

  unpackPhase = ''
    tar xf $src
    sourceRoot=wxWidgets-${version}
  '';

  patches = [
    (fetchurl {
      url = "https://github.com/wxWidgets/wxWidgets/commit/ed510012.patch";
      sha256 = "0f714caa562269ba40ea55e1ef2f1c800d0669f01c3862f47db183eb2db91567";
    })
    (fetchurl {
      url = "https://github.com/wxWidgets/wxWidgets/commit/8ea22b5e.patch";
      sha256 = "4e79b54088e513010cb2442d95ef23d6ab1cafd6a434090e1ead5c7b67c81e15";
    })
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
    "-DCMAKE_BUILD_TYPE=None"
    "-DwxBUILD_TOOLKIT=gtk3"
    "-DwxUSE_OPENGL=ON"
    "-DwxUSE_REGEX=sys"
    "-DwxUSE_ZLIB=sys"
    "-DwxUSE_EXPAT=sys"
    "-DwxUSE_LIBJPEG=sys"
    "-DwxUSE_LIBPNG=sys"
    "-DwxUSE_LIBTIFF=sys"
    "-DwxUSE_LIBLZMA=sys"
    "-DwxUSE_LIBMSPACK=ON"
    "-DwxUSE_PRIVATE_FONTS=ON"
    "-DwxUSE_GTKPRINT=ON"
  ];

  # buildPhase = ''
  #   runHook preBuild
  #   cmake -B build-gtk3 -S .
  #   cmake --build build-gtk3
  #   runHook postBuild
  # '';

  # installPhase = ''
  #   runHook preInstall
  #   DESTDIR=${placeholder "out"} cmake --install build-gtk3
  #   rm -r ${placeholder "out"}/usr/{include,lib/libwx_base*,bin/wxrc*}
  #   install -Dm644 $sourceRoot/docs/licence.txt ${placeholder "out"}/usr/share/licenses/${pname}/LICENSE
  #   runHook postInstall
  # '';

  meta = with lib; {
    description = "GTK+3 implementation of wxWidgets API for GUI";
    homepage = "https://wxwidgets.org";
    license = licenses.unfree; # TODO: "wxWindows Library Licence"
    platforms = platforms.linux;
    maintainers = with maintainers; [ ]; # Add your maintainer information here
  };
}
