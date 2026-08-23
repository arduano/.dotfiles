{ lib
, writeShellApplication
, symlinkJoin
, wineMakeraPortal
, wineWow64Packages
, ocl-icd
, libunwind
}:

let
  commonLibraries = lib.makeLibraryPath [
    ocl-icd
    libunwind
  ];

  portalLauncher = writeShellApplication {
    name = "makera-studio";
    text = ''
      base="$HOME/.local/share/makera-studio"
      prefix="$base/wineprefix"
      app="$prefix/drive_c/users/$USER/AppData/Local/Programs/Makera Studio/MakeraStudio.exe"

      if [[ ! -f "$app" ]]; then
        echo "Makera Studio is not installed at: $app" >&2
        exit 1
      fi

      export WINEPREFIX="$prefix"
      export WINE_FORCE_PORTAL=1
      export WINEDLLPATH="${wineMakeraPortal}/lib/wine"
      export WINEDLLOVERRIDES="opencl=b''${WINEDLLOVERRIDES:+;$WINEDLLOVERRIDES}"
      export OCL_ICD_VENDORS="''${OCL_ICD_VENDORS:-/run/opengl-driver/etc/OpenCL/vendors}"
      export LD_LIBRARY_PATH="/run/opengl-driver/lib:${commonLibraries}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      export WINEDEBUG="''${MAKERA_WINEDEBUG:--all}"
      unset MANGOHUD MANGOHUD_DLSYM

      cd "$(dirname "$app")"
      exec ${wineMakeraPortal}/bin/wine "$app" "$@"
    '';
  };

  legacyLauncher = writeShellApplication {
    name = "makera-studio-legacy";
    text = ''
      base="$HOME/.local/share/makera-studio"
      prefix="$base/wineprefix"
      app="$prefix/drive_c/users/$USER/AppData/Local/Programs/Makera Studio/MakeraStudio.exe"
      protonroot="$HOME/.local/share/Steam/steamapps/common/Proton - Experimental/files"

      if [[ ! -f "$app" ]]; then
        echo "Makera Studio is not installed at: $app" >&2
        exit 1
      fi

      export WINEPREFIX="$prefix"
      export WINEDLLPATH="$protonroot/lib/wine"
      export LD_LIBRARY_PATH="/run/opengl-driver/lib:${commonLibraries}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      export WINEDEBUG="''${MAKERA_WINEDEBUG:--all}"
      unset WINE_FORCE_PORTAL
      unset MANGOHUD MANGOHUD_DLSYM

      cd "$(dirname "$app")"
      exec ${wineWow64Packages.stable}/bin/wine "$app" "$@"
    '';
  };
in
symlinkJoin {
  name = "makera-studio-launchers";
  paths = [
    portalLauncher
    legacyLauncher
  ];
  meta = {
    description = "Reproducible Makera Studio launchers for the portal and legacy Wine runners";
    platforms = lib.platforms.linux;
  };
}
