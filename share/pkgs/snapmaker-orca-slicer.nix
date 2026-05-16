{ lib
, appimageTools
, fetchurl
, stdenvNoCC
, unzip
}:

let
  pname = "snapmaker-orca-slicer";
  version = "2.3.1";

  srcZip = fetchurl {
    url = "https://github.com/Snapmaker/OrcaSlicer/releases/download/v2.3.1/Snapmaker_Orca_Linux_ubuntu_2404_V2.3.1.zip";
    hash = "sha256-lC9Waom17oSoO28+AUBAFMBUDK6YvYJZOknEyxErW/s=";
  };

  appimage = stdenvNoCC.mkDerivation {
    pname = "${pname}-appimage";
    inherit version;

    src = srcZip;
    nativeBuildInputs = [ unzip ];

    dontUnpack = true;

    installPhase = ''
      runHook preInstall

      unzip -j "$src" "Snapmaker_Orca_Linux_AppImage_Ubuntu2404_V2.3.1.AppImage"
      install -Dm755 "Snapmaker_Orca_Linux_AppImage_Ubuntu2404_V2.3.1.AppImage" "$out/bin/${pname}.AppImage"

      runHook postInstall
    '';
  };

  src = "${appimage}/bin/${pname}.AppImage";

  extracted = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [
    webkitgtk_4_1
    glib-networking
  ];

  extraInstallCommands = ''
    sed -i '2iexport WEBKIT_DISABLE_DMABUF_RENDERER=1' "$out/bin/${pname}"
    sed -i '3iunset GTK_PATH GTK_MODULES' "$out/bin/${pname}"

    mkdir -p "$out/share/applications"
    printf '%s\n' \
      '[Desktop Entry]' \
      'Type=Application' \
      'Name=Snapmaker OrcaSlicer' \
      'Comment=Slice and prepare 3D models for Snapmaker printers' \
      'Exec=${pname} %F' \
      'Icon=${pname}' \
      'Terminal=false' \
      'Categories=Graphics;3DGraphics;' \
      'StartupNotify=true' \
      'StartupWMClass=snapmaker-orca' \
      'MimeType=model/stl;application/sla;application/vnd.ms-pki.stl;' \
      > "$out/share/applications/${pname}.desktop"

    icon_src="$(find ${extracted} -type f \( -iname '*.png' -o -iname '*.svg' -o -iname '*.xpm' \) | head -n 1 || true)"
    if [ -n "$icon_src" ]; then
      ext="''${icon_src##*.}"
      mkdir -p "$out/share/icons/hicolor/256x256/apps"
      install -Dm644 "$icon_src" "$out/share/icons/hicolor/256x256/apps/${pname}.''${ext}"
    fi
  '';

  meta = with lib; {
    description = "Snapmaker OrcaSlicer AppImage wrapper";
    homepage = "https://github.com/Snapmaker/OrcaSlicer";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.agpl3Plus;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
