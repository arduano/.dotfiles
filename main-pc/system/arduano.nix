{ pkgs, lib, ... }: {
  # BROKEN
  # arduano.sunshine.enable = true;

  arduano.syncNixChannel.enable = true;

  arduano.networking.enable = true;
  arduano.shell.enable = true;
  arduano.portals.enable = true;
  arduano.locale.enable = true;
  arduano.nix-ld.enable = true;

  networking.useDHCP = lib.mkForce true;
  services.flatpak.enable = true;

  services.udev.extraRules = ''
    # ODrive USB device rules
    SUBSYSTEM=="usb", ATTR{idVendor}=="1209", ATTR{idProduct}=="0d3[0-9]", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", MODE="0666"
  '';

  environment.systemPackages = with pkgs.arduano.groups; with pkgs; [
    printrun # For 3d printing

    arduano.sendgcode

    kdePackages.sddm-kcm
    gpclient
    gpauth

    arduino-ide
    python3Packages.pyserial
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
  hardware.nvidia-container-toolkit.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.xautolock.enable = false;
  services.xserver.xautolock.time = 99999999;
  services.logind.settings.Login.HandlePowerKey = "suspend";
  programs.steam.enable = true;
}
