{ lib
, stdenv
, fetchzip
, autoPatchelfHook
, makeWrapper

# runtime libs (Electron/Chromium-style)
, alsa-lib
, at-spi2-core
, cairo
, cups
, dbus
, expat
, gdk-pixbuf
, glib
, gtk3
, libGL
, libdrm
, mesa
, libpulseaudio
, libsecret
, libuuid
, libgbm
, nss
, nspr
, pango

, libX11
, libXcomposite
, libXcursor
, libXdamage
, libXext
, libXfixes
, libXi
, libXrandr
, libXrender
, libXScrnSaver
, libXtst
, libxcb
, libxkbcommon

, version ? "8.0.1"
}:

stdenv.mkDerivation rec {
  pname = "inav-configurator";
  inherit version;

  src = fetchzip {
    # x86_64-linux build; adjust if you need other platforms
    url = "https://github.com/iNavFlight/inav-configurator/releases/download/${version}/INAV-Configurator_linux_x64_${version}.zip";
    sha256 = "sha256-/TTey3OWA7fhjqffoU2WWrp7ghU1oifW20xu4BMp9xY=";
  };

  nativeBuildInputs = [
    # autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    alsa-lib
    at-spi2-core
    cairo
    cups
    dbus
    expat
    gdk-pixbuf
    glib
    gtk3
    libGL
    libdrm
    mesa
    libpulseaudio
    libsecret
    libuuid
    libgbm
    nss
    nspr
    pango

    libX11
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXScrnSaver
    libXtst
    libxcb
    libxkbcommon
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/inav-configurator $out/bin
    cp -r ./* $out/opt/inav-configurator/

    # main binary in the archive is typically called "INAV-Configurator"
    makeWrapper $out/opt/inav-configurator/inav-configurator \
      $out/bin/inav-configurator \
      --set LD_LIBRARY_PATH "${lib.makeLibraryPath buildInputs}"

    runHook postInstall
  '';

  meta = with lib; {
    description = "INAV Configurator ${version}";
    homepage    = "https://github.com/iNavFlight/inav-configurator";
    license     = licenses.gpl3Plus;
    platforms   = [ "x86_64-linux" ];
  };
}
