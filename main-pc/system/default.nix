{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./arduano.nix
    ./hardware-configuration.nix
  ];

  arduano.roles.base = {
    enable = true;
    arduanoExtraGroups = [
      "docker"
      "dialout"
    ];
  };
  arduano.roles.desktop-main-pc.enable = true;
  arduano.roles.main-pc-hardware-workbench.enable = true;
  arduano.workVm = {
    enable = true;
    cloudflareWarp = {
      enable = true;
      package = pkgs.cloudflare-warp.overrideAttrs (previous: {
        version = "2026.7.1343.0";
        src = pkgs.fetchurl {
          name = "cloudflare-warp_2026.7.1343.0_amd64.deb";
          url = "https://downloads.cloudflareclient.com/v1/download/noble-intel/version/2026.7.1343.0";
          hash = "sha256-C0u01lhECaHPBDHPIc+yOlDYyHepwCBzJxEaHAV7EF4=";
        };
        buildInputs = previous.buildInputs ++ [ pkgs.tpm2-tss ];
        # The daemon and CLI are fully patched. The remaining optional shared
        # objects belong to the inactive Flutter taskbar/captive-portal UI.
        autoPatchelfIgnoreMissingDeps = previous.autoPatchelfIgnoreMissingDeps ++ [
          "libayatana-appindicator3.so.1"
          "libayatana-ido3-0.4.so.0"
          "libayatana-indicator3.so.7"
          "libcurl.so.4"
          "libdbusmenu-glib.so.4"
          "libjavascriptcoregtk-4.1.so.0"
          "libjvm.so"
          "libsoup-3.0.so.0"
          "libwebkit2gtk-4.1.so.0"
        ];
      });
      expectedPrivateDestinations = [ "100.64.0.0/10" ];
    };
  };

  nix.settings.trusted-users = [
    "root"
    "arduano"
  ];

  networking.hostName = "main-pc";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
