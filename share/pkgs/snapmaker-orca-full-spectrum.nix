{ lib
, appimageTools
, fetchurl
, libglvnd
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
    libglvnd
  ];

  extraInstallCommands = ''
    # Match the primary Snapmaker Orca wrapper behavior. main-pc testing,
    # 2026-05: Full X11 + GPU works; Wayland software GL works but is slow;
    # Wayland/Xwayland GPU and Zink paths crash with Mesa zink
    # VK_ERROR_MEMORY_MAP_FAILED. Keep explicit launchers for future retests.
    sed -i '2iexport WEBKIT_DISABLE_DMABUF_RENDERER=1' "$out/bin/${pname}"
    sed -i '3iexport WEBKIT_DISABLE_COMPOSITING_MODE=1' "$out/bin/${pname}"
    sed -i '4iexport GDK_BACKEND=x11' "$out/bin/${pname}"
    sed -i '5iexport LIBGL_ALWAYS_SOFTWARE=1' "$out/bin/${pname}"
    sed -i '6iexport MESA_LOADER_DRIVER_OVERRIDE=llvmpipe' "$out/bin/${pname}"
    sed -i '7iexport GALLIUM_DRIVER=llvmpipe' "$out/bin/${pname}"
    sed -i '8iunset __GLX_VENDOR_LIBRARY_NAME __EGL_VENDOR_LIBRARY_FILENAMES VK_ICD_FILENAMES' "$out/bin/${pname}"
    sed -i '9iunset GTK_PATH GTK_MODULES QT_PLUGIN_PATH QML2_IMPORT_PATH' "$out/bin/${pname}"
    # Keep this fork's mutable app state separate from the primary Orca profile;
    # both apps otherwise identify as closely related Orca builds.
    sed -i '10iexport XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}/snapmaker-orca-full-spectrum"' "$out/bin/${pname}"
    sed -i '11iexport XDG_DATA_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}/snapmaker-orca-full-spectrum"' "$out/bin/${pname}"
    sed -i '12iexport XDG_CACHE_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}/snapmaker-orca-full-spectrum"' "$out/bin/${pname}"
    sed -i '13imkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME"' "$out/bin/${pname}"

    # Full Plasma X11 sessions can use this GPU path with good preview FPS.
    cp "$out/bin/${pname}" "$out/bin/${pname}-gpu"
    substituteInPlace "$out/bin/${pname}-gpu" \
      --replace-fail 'export LIBGL_ALWAYS_SOFTWARE=1' 'export LD_LIBRARY_PATH="${libglvnd}/lib:/run/opengl-driver/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"' \
      --replace-fail 'export MESA_LOADER_DRIVER_OVERRIDE=llvmpipe' 'export LIBGL_DRIVERS_PATH=/run/opengl-driver/lib/dri' \
      --replace-fail 'export GALLIUM_DRIVER=llvmpipe' 'export __GLX_VENDOR_LIBRARY_NAME=nvidia' \
      --replace-fail 'unset __GLX_VENDOR_LIBRARY_NAME __EGL_VENDOR_LIBRARY_FILENAMES VK_ICD_FILENAMES' 'unset LIBGL_ALWAYS_SOFTWARE MESA_LOADER_DRIVER_OVERRIDE GALLIUM_DRIVER __EGL_VENDOR_LIBRARY_FILENAMES VK_ICD_FILENAMES'

    # Experimental Wayland-native Zink path. Kept for retesting after Mesa,
    # NVIDIA, or Snapmaker Orca updates; currently crashes on main-pc.
    cp "$out/bin/${pname}" "$out/bin/${pname}-zink"
    substituteInPlace "$out/bin/${pname}-zink" \
      --replace-fail 'export GDK_BACKEND=x11' 'export GDK_BACKEND=wayland' \
      --replace-fail 'export LIBGL_ALWAYS_SOFTWARE=1' 'export LD_LIBRARY_PATH="${libglvnd}/lib:/run/opengl-driver/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"' \
      --replace-fail 'export MESA_LOADER_DRIVER_OVERRIDE=llvmpipe' 'export MESA_LOADER_DRIVER_OVERRIDE=zink' \
      --replace-fail 'export GALLIUM_DRIVER=llvmpipe' 'export GALLIUM_DRIVER=zink' \
      --replace-fail 'unset __GLX_VENDOR_LIBRARY_NAME __EGL_VENDOR_LIBRARY_FILENAMES VK_ICD_FILENAMES' 'export __GLX_VENDOR_LIBRARY_NAME=mesa; export __EGL_VENDOR_LIBRARY_FILENAMES=/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json; export VK_ICD_FILENAMES=/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json; export LIBGL_DRIVERS_PATH=/run/opengl-driver/lib/dri'

    # Experimental Xwayland+Zink path. Also crashes on main-pc today.
    cp "$out/bin/${pname}-zink" "$out/bin/${pname}-xwayland-zink"
    substituteInPlace "$out/bin/${pname}-xwayland-zink" \
      --replace-fail 'export GDK_BACKEND=wayland' 'export GDK_BACKEND=x11'

    mv "$out/bin/${pname}" "$out/bin/${pname}-software"
    cat > "$out/bin/${pname}" <<EOF
    #!/usr/bin/env bash
    set -euo pipefail

    if [ "\''${XDG_SESSION_TYPE:-}" = "x11" ]; then
      exec "$out/bin/${pname}-gpu" "\$@"
    fi

    exec "$out/bin/${pname}-software" "\$@"
    EOF
    chmod +x "$out/bin/${pname}"

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
