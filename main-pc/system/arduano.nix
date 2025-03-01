{ pkgs, lib, ... }: {
  # BROKEN
  # arduano.sunshine.enable = true;

  arduano.syncNixChannel.enable = true;

  arduano.networking.enable = true;
  arduano.shell.enable = true;
  arduano.portals.enable = true;
  arduano.locale.enable = true;
  arduano.nix-ld.enable = true;

  # networking.useDHCP = lib.mkForce true;
  # networking.interfaces.enp5s0.ipv4.addresses = [{
  #   address = "192.168.1.52";
  #   prefixLength = 24;
  # }];
  # networking.defaultGateway = "192.168.1.1";
  # networking.nameservers = [ "192.168.1.1" "1.1.1.1" "1.0.0.1" ];

  environment.systemPackages = with pkgs.arduano.groups; with pkgs; [
    # BROKEN
    # printrun # For 3d printing
  ] ++
  build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming ++ gui-root;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.openssh = {
    enable = true;
    ports = [ 45754 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  services.duplicati = {
    enable = true;
    user = "arduano";
  };

  services = {
    syncthing = {
      enable = true;
      user = "arduano";
      configDir = "/home/arduano/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
    };
  };

  virtualisation.docker.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # services.hardware.openrgb = {
  #   enable = true;
  #   package = pkgs.openrgb-with-all-plugins;
  # };
  # boot.blacklistedKernelModules = [ "ee1004" ];

  services.xserver.xautolock.enable = false;
  services.xserver.xautolock.time = 99999999;
  services.logind.powerKey = "suspend";
}
