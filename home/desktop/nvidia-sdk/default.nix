{ config, pkgs, inputs, ... }:

with pkgs;
let
  src = fetchurl
    {
      url = "https://static.arduano.io/uploads/sdkmanager_1.9.2-10899_amd64.deb";
      sha256 = "sha256-YP1E8Mu9/Jph3l7wuwzLz7mHxE7SghAPPuyoIi9aLg4=";
    };

  deps = with xorg; [
    libcxx
    systemd
    libpulseaudio
    libdrm
    mesa
    stdenv.cc.cc
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libglvnd
    libnotify
    libX11
    libXcomposite
    libunity
    libuuid
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXtst
    libxshmfence
    nspr
    libxcb
    pango
    libXScrnSaver
    libappindicator-gtk3
    libdbusmenu
    nss
    wayland
  ];

  libs = lib.makeLibraryPath deps;

  sdk-unpacked = runCommand "nvidia-sdk-install"
    {
      nativeBuildInputs = [ makeWrapper ];
      buildInputs = [ dpkg ];
    } ''
    dpkg-deb -x ${src} .

      mkdir -p $out
      mv ./usr/share $out

      mkdir -p $out/opt
      mv ./opt/nvidia $out/opt/nvidia

      mkdir -p $out/bin

      makeWrapper $out/opt/nvidia/sdkmanager/sdkmanager $out/bin/sdkmanager \
        --prefix LD_LIBRARY_PATH : "${libs}"
  '';

  nvidia-sdk = buildFHSEnv {
    name = "nvidia-sdk-manager";
    targetPkgs = pkgs: (builtins.concatLists [ [ sdk-unpacked ] deps ]);
    profile = ''
      '';

    runScript = "sdkmanager";

    meta = {
      description = "";
      homepage = "";
      platforms = lib.platforms.linux;
      license = [ ];
      maintainers = with lib.maintainers; [ ];
    };
  };
in
{
  home.packages = [ nvidia-sdk ];
}
