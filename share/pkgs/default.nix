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
      fastfetch
      pciutils
      htop
      btop
      tmux
      git
      ncdu
      nload
      pv
      jq
      usbutils
      nmap
      xz
      powertop
      gh

      (pkgs.writeShellScriptBin "switch-system" ''
        nice -19 sudo nixos-rebuild switch -L -v --flake $HOME/.dotfiles &&
        xdg-desktop-menu forceupdate
      '')

      (pkgs.writeShellScriptBin "nrun" ''
        # Run the first arg, with the rest of the args as arguments, in a nix shell
        NIXPKGS_ALLOW_UNFREE=1 nix run --impure "nixpkgs#$1" -- ''${@:2}
      '')

      (pkgs.writeShellScriptBin "run-full-os-gc" ''
        sudo nix-env --delete-generations +1 &&
          sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system +1 &&
          nix-env --delete-generations +1 &&
          nix store gc &&
          switch
      '')
    ];

    shell-useful = with pkgs; [
      imagemagick
      p7zip
      ffmpeg
      arduano.nodePkgs."@marp-team/marp-cli"
      xclip
      sapling
    ];

    shell-programming = with pkgs; [
      arduano.nodePkgs."@withgraphite/graphite-cli"

      (python3.override { x11Support = true; })
      python311Packages.tkinter

      nodejs_20
      nodePackages.yarn
      bun
      deno

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
      kdePackages.isoimagewriter
    ];

    gui-user = with pkgs; [
      qpwgraph
      qalculate-qt
      teams-for-linux
      slack
      google-chrome
      brave
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
      mpv
      peek
      signal-desktop
      plexamp
      kdenlive
      krita
      qbittorrent
      drawing
      yakuake
      libsForQt5.kamoso
      (callPackage ./imhex { })
    ];
  };
}
