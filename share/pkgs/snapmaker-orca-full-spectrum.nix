{ lib
, appimageTools
, fetchurl
}:

let
  pname = "snapmaker-orca-full-spectrum";
  version = "0.9.7";

  src = fetchurl {
    url = "https://github.com/ratdoux/OrcaSlicer-FullSpectrum/releases/download/v0.9.7/Snapmaker_Orca_Linux_AppImage_Ubuntu2404_V0.9.7.AppImage";
    hash = "sha256-ddDhT0olmnuHGC1+aoZUA4/L0YQcC7X918hKVmTND3Y=";
  };

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
        sed -i '4iexport XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}/snapmaker-orca-full-spectrum"' "$out/bin/${pname}"
        sed -i '5iexport XDG_DATA_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}/snapmaker-orca-full-spectrum"' "$out/bin/${pname}"
        sed -i '6iexport XDG_CACHE_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}/snapmaker-orca-full-spectrum"' "$out/bin/${pname}"
        sed -i '7imkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME"' "$out/bin/${pname}"
        mkdir -p "$out/share/applications"
    printf '%s\n' \
      '[Desktop Entry]' \
      'Type=Application' \
      'Name=Snapmaker Orca Full Spectrum' \
      'Comment=Slice and prepare 3D models with the Full Spectrum Snapmaker Orca fork' \
      'Exec=${pname} %F' \
      'Icon=${pname}' \
      'Terminal=false' \
      'Categories=Graphics;3DGraphics;' \
      'StartupNotify=true' \
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
    description = "Snapmaker Orca Full Spectrum AppImage wrapper";
    homepage = "https://github.com/ratdoux/OrcaSlicer-FullSpectrum";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.agpl3Plus;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
