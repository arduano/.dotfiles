{ pkgs, ... }: {
  arduano.syncNixChannel.enable = true;

  arduano.networking.enable = true;
  arduano.shell.enable = true;
  arduano.locale.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  environment.systemPackages = with pkgs.arduano.groups;
    build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming ++ gui-root;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = false; # Disable fprintd for sddm

  virtualisation.docker.enable = true;

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
  };

  services.openssh = {
    enable = true;
    ports = [ 45754 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  services.logind.settings.Login.HandlePowerKey = "suspend";
}
