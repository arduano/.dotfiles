{ callPackage
, pkgs
}:

{
  sunshine_patched = callPackage ./sunshine { };
  wxwidgets_gtk3 = callPackage ./wxwidgets { };
  p7zip-gui = callPackage ./p7zip-gui { };
  tidal-dl = callPackage ./tidal-dl { };
  nodePkgs = callPackage ./nodePkgs { };
  gpustat = callPackage ./gpustat { };

  groups = {
    build-essentials = with pkgs; [
      gcc
      gpp
      cmake
      pkg-config
      gnumake
      ninja
    ];

    shell-essentials = with pkgs; [
      vim
      wget
      curl
      ripgrep
      nload
      neofetch
      fastfetch
      pciutils
      htop
      tmux
      git
      ncdu
      nload
      pv
      jq
      usbutils
      nmap
      xz
    ];

    shell-useful = with pkgs; [
      imagemagick
      p7zip
      nix-du
      ffmpeg
      arduano.nodePkgs."@marp-team/marp-cli"
      ollama
    ];

    shell-programming = with pkgs; [
      arduano.nodePkgs."@withgraphite/graphite-cli"

      (python3.override { x11Support = true; })
      python311Packages.tkinter

      nodejs_20
      nodePackages.yarn

      rustup
      gdb
      nixpkgs-fmt
      lldb

      minicom

      cargo-fuzz
      cargo-outdated
      cargo-audit
      cargo-license
      cargo-flamegraph

      (pkgs.writeShellScriptBin "fixfmt" ''
        git add . && cargo fix --workspace --allow-staged && cargo fmt --all
      '')
    ];

    gui-root = with pkgs; [
      gparted
    ];

    gui-user = with pkgs; [
      qpwgraph
      qalculate-qt
      teams-for-linux
      slack
      google-chrome
      zoom-us
      gimp
      arduano.p7zip-gui
      firefox
      steam
      vlc
      kate
      vscode-fhs
      flameshot
      konversation
      vesktop
      libreoffice
    ];
  };
}
