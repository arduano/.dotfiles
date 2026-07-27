{ pkgs, ... }: {
  arduano.syncNixChannel.enable = true;

  arduano.networking.enable = true;
  arduano.shell.enable = true;
  arduano.locale.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  programs.steam.enable = true;

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

  # Keep the laptop's existing suspend-then-hibernate policy when syncing the
  # canonical dotfiles back from home-nas. The current active boot entry
  # already resumes from the labelled swap partition.
  boot.resumeDevice = "/dev/disk/by-label/swap";

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend-then-hibernate";
    HandlePowerKey = "suspend-then-hibernate";
    HandleSuspendKey = "suspend-then-hibernate";
  };

  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "30min";
    HibernateOnACPower = true;
    SuspendState = "mem";
  };
}
