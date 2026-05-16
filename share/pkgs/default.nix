{ callPackage
, python3Packages
, pkgs
}:

rec {
  sunshine_patched = callPackage ./sunshine { };
  tidal-dl = callPackage ./tidal-dl { };
  nodePkgs = callPackage ./nodePkgs { };
  gpustat = callPackage ./gpustat { };
  gogcli = callPackage ./gogcli { };
  prismlauncher = callPackage ./prismlauncher { };
  libvinput = callPackage ./libvinput { };
  vinput = callPackage ./vinput { };
  sendgcode = callPackage ./sendgcode.nix { };
  inav-configurator = callPackage ./inav-configurator.nix { };
  snapmaker-orca-slicer = callPackage ./snapmaker-orca-slicer.nix { };
  snapmaker-orca-full-spectrum = callPackage ./snapmaker-orca-full-spectrum.nix { };

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
      lsof
      pv
      jq
      usbutils
      nmap
      xz
      powertop
      gh
      unzip

      nix-output-monitor

      (pkgs.writeShellScriptBin "switch-system" ''
        nice -19 nom build --no-link $HOME/.dotfiles#nixosConfigurations.$(hostname).config.system.build.toplevel
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
      signal-cli
    ];

    shell-programming = with pkgs; [
      arduano.nodePkgs."@withgraphite/graphite-cli"

      python3

      nodejs_24
      yarn
      deno
      pnpm

      beads

      dotnet-sdk_8
      rustup
      gdb
      nixpkgs-fmt
      # lldb # BROKEN

      minicom

      cargo-fuzz
      # cargo-outdated # BROKEN
      # cargo-audit # BROKEN
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
      zen-browser
      zoom-us
      gimp
      firefox
      vlc
      kdePackages.kate
      vscode-fhs
      flameshot
      kdePackages.konversation
      vesktop
      libreoffice
      mpv
      peek
      signal-desktop
      plexamp
      kdePackages.kdenlive
      krita
      qbittorrent
      drawing
      kdePackages.yakuake
      # (callPackage ./imhex { })
      obsidian
      anydesk
      gyroflow
    ];
  };
}
