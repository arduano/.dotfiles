{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  arduano.roles.base = {
    enable = true;
    createUserHomes = true;
    arduanoExtraGroups = [ "video" "input" "docker" ];
  };

  networking.hostName = "kiosk-laptop-1";
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;
  virtualisation.docker.enable = true;
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  users.users.arduano.initialPassword = "nixos";
  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "root" "arduano" ];

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
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # The machine is currently operating as a bare board with the original
  # display attached. Avoid suspend from a confused or floating lid state.
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # These parameters are already proven on the recovery image on this exact
  # Toshiba Satellite Z930 hardware.
  boot.kernelParams = [
    "i915.enable_psr=0"
    "button.lid_init_state=open"
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.graphics.enable = true;
  services.thermald.enable = true;
  services.fstrim.enable = true;
  zramSwap.enable = true;

  boot.loader.timeout = 1;
  boot.loader.systemd-boot.configurationLimit = 5;

  environment.systemPackages = with pkgs; [
    curl
    git
    htop
    pciutils
    smartmontools
    tmux
    usbutils
    vim
    wget
    lm_sensors
    (pkgs.writeShellScriptBin "kiosk-rebuild" ''
      exec sudo nixos-rebuild switch --refresh \
        --flake 'git+https://github.com/arduano/.dotfiles.git#kiosk-laptop-1' "$@"
    '')
  ];

  nix.settings.auto-optimise-store = true;

  system.stateVersion = "26.05";
}
