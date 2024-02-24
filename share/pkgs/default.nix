{ callPackage
, pkgs
}:

{
  sunshine_patched = callPackage ./sunshine { };
  wxwidgets_gtk3 = callPackage ./wxwidgets { };
  p7zip-gui = callPackage ./p7zip-gui { };
  tidal-dl = callPackage ./tidal-dl { };

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
    ];

    gui-useful = with pkgs; [
      gparted
    ];
  };
}
