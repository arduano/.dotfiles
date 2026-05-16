{ lib
, makeWrapper
, signal-desktop
, symlinkJoin
}:

symlinkJoin {
  pname = "signal-desktop-xwayland";
  inherit (signal-desktop) version;

  paths = [ signal-desktop ];
  nativeBuildInputs = [ makeWrapper ];

  postBuild = ''
    # Native Wayland Electron makes Signal drag/resize interactions stall KWin
    # animations on Plasma Wayland/NVIDIA. Xwayland is stable for Signal.
    wrapProgram $out/bin/signal-desktop \
      --add-flags "--ozone-platform=x11"
  '';

  meta = signal-desktop.meta // {
    description = "${signal-desktop.meta.description} (Xwayland launcher)";
    mainProgram = "signal-desktop";
  };
}
