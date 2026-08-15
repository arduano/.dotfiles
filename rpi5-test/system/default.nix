{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.display-vc4
  ];

  # The maintained generational Pi bootloader is recommended for new Pi 5
  # installations. It updates /boot/firmware as part of every activation.
  boot.loader.raspberry-pi.bootloader = "kernel";

  disko.devices.disk.nvme = {
    type = "disk";
    device = "/dev/nvme0n1";
    content = {
      type = "gpt";
      partitions = {
        firmware = {
          priority = 1;
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot/firmware";
            mountOptions = [
              "fmask=0022"
              "dmask=0022"
            ];
          };
        };

        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
            mountOptions = [ "noatime" ];
          };
        };
      };
    };
  };

  networking = {
    hostName = "rpi5-test";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  systemd.services = {
    NetworkManager-wait-online.enable = lib.mkForce false;
    systemd-networkd-wait-online.enable = lib.mkForce false;
  };

  users.users.arduano = {
    isNormalUser = true;
    createHome = true;
    initialPassword = "nixos";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICTRANHakQog7l2Ftk/3EtcExKJJ1PmG8lytv+9LXxl9 arduano@home-nas"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
    };
  };

  hardware.enableRedistributableFirmware = true;
  zramSwap.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "arduano"
    ];
    auto-optimise-store = true;
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    htop
    raspberrypi-eeprom
    tmux
    usbutils
    vim
  ];

  time.timeZone = "Australia/Sydney";
  system.stateVersion = "26.05";
}
