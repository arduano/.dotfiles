{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./borgbackup.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 7;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  # Don't let systemd-fstab-generator synthesize the root mount for a
  # colon-joined multi-device bcachefs filesystem; provide sysroot.mount
  # explicitly below instead.
  boot.initrd.systemd.root = null;
  boot.initrd.systemd.settings.Manager = {
    # bcachefs root recovery can legitimately take longer than systemd's
    # default 90s start/device timeouts during early boot.
    DefaultDeviceTimeoutSec = "infinity";
    DefaultTimeoutStartSec = "infinity";
  };
  boot.initrd.systemd.services.mount-bcachefs-root = {
    description = "Mount bcachefs root directly";
    unitConfig.DefaultDependencies = false;
    requiredBy = [ "initrd-root-fs.target" ];
    before = [ "initrd-root-fs.target" ];
    requires = [ "unlock-bcachefs--.service" ];
    after = [ "unlock-bcachefs--.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      mkdir -p /sysroot
      exec ${pkgs.util-linux}/bin/mount -t bcachefs -o degraded \
        /dev/disk/by-id/ata-WDC_WD80EFPX-68C4ZN0_WD-RD1B44VD:/dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV2NBA6:/dev/disk/by-id/ata-WDC_WD80EFPX-68C4ZN0_WD-RD1DNDWD:/dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV2NDW6:/dev/disk/by-id/nvme-eui.0025385581b21585-part2 \
        /sysroot
    '';
  };

  networking.hostName = "home-nas"; # Define your hostname.

  # arduano.syncNixChannel.enable = true;

  # arduano.vscode-server.enable = true;
  # services.vscode-server.enable = true;

  arduano.networking.enable = true;
  arduano.shell.enable = true;
  arduano.locale.enable = true;

  networking.useDHCP = lib.mkDefault true;
  # networking.enableIPv6 = true;
  # networking.interfaces.enp3s0.ipv4.addresses = [{
  #   address = "192.168.1.51";
  #   prefixLength = 24;
  # }];
  # networking.defaultGateway = "192.168.1.1";
  # networking.nameservers = [ "192.168.1.1" "1.1.1.1" "1.0.0.1" ];

  environment.systemPackages = (with pkgs.arduano.groups;
    build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming)
    ++ [ pkgs.chromium pkgs.arduano.gogcli ];

  virtualisation.docker.enable = true;

  users.users.arduano = {
    isNormalUser = true;
    createHome = true;
    description = "arduano";
    extraGroups = [ "networkmanager" "wheel" "fuse" "docker" ];
    packages = with pkgs; [ ];
  };
  users.users.recovery = {
    isNormalUser = true;
    createHome = true;
    description = "recovery";
    extraGroups = [ "networkmanager" "wheel" "fuse" ];
    packages = with pkgs; [ ];
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      AllowTcpForwarding = "yes";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Network discovery
  services.avahi = {
    enable = true;
    reflector = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };

  services = {
    syncthing = {
      enable = true;
      user = "arduano";
      configDir = "/home/arduano/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_testing;
  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_16.override {
  #   argsOverride = rec {
  #     src = pkgs.fetchgit {
  #       url = "https://evilpiepirate.org/git/bcachefs.git";
  #       rev = "e57a3d4f367ea2d2c9887e08b070d5e2a060054d";
  #       sha256 = "sha256-uzi8J96SQtNZndUhQCNSeNwU2j4PYeuan0CinwdBE7o=";
  #     };
  #     version = "6.16-bcachefs";
  #     modDirVersion = "6.16.0-rc6";
  #   };
  # });

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.duplicati = {
    enable = true;
    user = "arduano";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
