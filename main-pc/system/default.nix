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
    inputs.vm-harness.nixosModules.vm-harness-host
  ];

  # The broker authenticates the unprivileged controller with SO_PEERCRED, so
  # this host identity is deliberately stable and explicit.
  users.users.arduano.uid = 1000;

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
      # The managed client currently establishes MASQUE/HTTP3 successfully but
      # receives no inner packets. Force its concurrent HTTP/2 transport to win
      # without changing host-root networking or organization credentials.
      forceMasqueHttp2 = true;
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

  # This is the only VM Harness component that crosses the root boundary. It
  # exposes a fixed, peer-authenticated Unix-socket protocol to the unprivileged
  # workspace controller; workload selection and all VM orchestration remain in
  # the user's workspace flake.
  services.vm-harness-host-broker = {
    enable = true;
    controllerUser = "arduano";
    controllerUid = 1000;
    controllerGroup = "vm-harness-controller";
    controllerGid = 981;
    networkNamespacePath = "/run/netns/work-vm";
    namespaceUnit = "work-vm-netns.service";
    warpUnit = "cloudflare-warp.service";
    warpPackage = config.arduano.workVm.cloudflareWarp.package;
    policyProfiles.private-split = {
      dns = [
        {
          # The guest sees only this synthetic address. passt translates its
          # DNS traffic to WARP's namespace-local resolver below.
          forward = "10.0.2.3";
          host = "127.0.2.3";
        }
      ];
      mtu = 1280;
      digest = "sha256:c426223b8999b49efe1f36ce924ef776e8d6b33da47e5c4ae940e67f01f363db";
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
