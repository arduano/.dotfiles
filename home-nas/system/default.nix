{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "home-nas"; # Define your hostname.

  arduano.syncNixChannel.enable = true;

  # arduano.vscode-server.enable = true;
  # services.vscode-server.enable = true;

  arduano.networking.enable = true;
  # arduano.shell.enable = true;

  # networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp3s0.ipv4.addresses = [{
    address = "192.168.1.51";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "192.168.1.1" "1.1.1.1" "1.0.0.1" ];

  environment.systemPackages = with pkgs.arduano.groups;
    build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming ++ gui-root ++ gui-root;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

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
  services.avahi.enable = true;
  services.avahi.publish.userServices = true;

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_testing;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
