{ callPackage
, python3Packages
, pkgs
}:

rec {
  nodePkgs = callPackage ./nodePkgs { };
  gpustat = callPackage ./gpustat { };
  gogcli = callPackage ./gogcli { };
  snapmaker-orca-slicer = callPackage ./snapmaker-orca-slicer.nix { };
  snapmaker-orca-full-spectrum = callPackage ./snapmaker-orca-full-spectrum.nix { };
  signal-desktop-xwayland = callPackage ./signal-desktop-xwayland.nix { };

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
        set -euo pipefail

        action="''${1:-switch}"
        host="''${2:-$(hostname)}"
        flake="''${DOTFILES_DIR:-$HOME/.dotfiles}"

        case "$action" in
          switch|boot|test|dry-activate|build) ;;
          -h|--help)
            echo "usage: switch-system [switch|boot|test|dry-activate|build] [host]"
            exit 0
            ;;
          *)
            echo "switch-system: unsupported action '$action'" >&2
            echo "usage: switch-system [switch|boot|test|dry-activate|build] [host]" >&2
            exit 2
            ;;
        esac

        attr="$flake#nixosConfigurations.$host.config.system.build.toplevel"

        if [[ "$action" == "build" ]]; then
          exec nice -n 19 nom build --out-link result "$attr"
        fi

        tmpdir="$(mktemp -d)"
        trap 'rm -rf "$tmpdir"' EXIT

        out_link="$tmpdir/system"
        nice -n 19 nom build --out-link "$out_link" "$attr"
        system_path="$(readlink -f "$out_link")"

        nice -n 19 sudo nixos-rebuild "$action" -L -v --store-path "$system_path"

        if [[ "$action" == "switch" || "$action" == "test" ]] && command -v xdg-desktop-menu >/dev/null; then
          xdg-desktop-menu forceupdate || true
        fi
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
      arduano.nodePkgs
      xclip
      sapling
      signal-cli
    ];

    shell-programming = with pkgs; [
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
      arduano.signal-desktop-xwayland
      plexamp
      kdePackages.kdenlive
      krita
      qbittorrent
      drawing
      kdePackages.yakuake
      obsidian
      anydesk
      gyroflow
    ];
  };
}
