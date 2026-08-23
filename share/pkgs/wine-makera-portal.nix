{ lib
, fetchurl
, wineWow64Packages
}:

let
  baseWine = wineWow64Packages.stable.override {
    dbusSupport = true;
    openclSupport = true;
  };
in
baseWine.overrideAttrs (old: {
  pname = "wine-makera-portal";
  version = "11.16";

  src = fetchurl {
    url = "https://dl.winehq.org/wine/source/11.x/wine-11.16.tar.xz";
    hash = "sha256-xm4gkDQ9zXJ/f3/S+H7gv7CxGHkMHXRat7ikw6QZfy8=";
  };

  # Wine 11.16 already contains the device-path loader change carried by the
  # pinned nixpkgs Wine 11.0 package, so retain only still-applicable upstream
  # packaging patches before adding the portal series.
  patches = (builtins.filter
    (patch: !(lib.hasInfix "add-dll-accept-device-paths" (toString patch)))
    (old.patches or [ ])) ++ [
    ./wine-makera-portal-patches/0001-comdlg32-add-XDG-desktop-portal-backend-for-file-dia.patch
    ./wine-makera-portal-patches/0002-comdlg32-route-IFileDialog-through-portal-when-compa.patch
    ./wine-makera-portal-patches/0003-winecfg-add-portal-file-dialog-policy-and-UI.patch
    ./wine-makera-portal-patches/0004-comdlg32-tests-add-IFileOpenDialog-FOS_PICKFOLDERS-r.patch
    ./wine-makera-portal-patches/0005-shell32-route-SHBrowseForFolderW-through-portal-when.patch
  ];

  meta = (old.meta or { }) // {
    description = "Wine 11.16 with XDG portal file dialogs for Makera Studio";
    longDescription = ''
      A Makera-scoped Wine build with the five commits from Wine merge request
      !10060. The patch routes compatible Win32 common file dialogs, IFileDialog,
      and folder pickers through XDG Desktop Portal while retaining Wine's
      normal dialog implementation as a fallback.
    '';
    platforms = lib.platforms.linux;
  };
})
