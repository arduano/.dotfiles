{ pkgs, ... }: {
  arduano.syncNixChannel.enable = true;

  arduano.networking.enable = true;
  arduano.shell.enable = true;
  arduano.portals.enable = true;
  arduano.locale.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  environment.systemPackages = with pkgs.arduano.groups; with pkgs; [
    kdePackages.sddm-kcm
  ] ++ build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming ++ gui-root;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = false; # Disable fprintd for sddm

  virtualisation.docker.enable = true;

  virtualisation.docker.enable = true;

  services.logind.extraConfig = ''
    IdleAction=suspend-then-hibernate
    IdleActionSec=5m
  '';
  services.logind.lidSwitchDocked = "suspend-then-hibernate";
  services.logind.lidSwitchExternalPower = "suspend-then-hibernate";
  services.logind.lidSwitch = "suspend-then-hibernate";

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 70; # Below this, it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # Above this, it stops charging
    };
  };

  networking.networkmanager = {
    # settings = {
    #   logging = {
    #     level = "DEBUG";
    #   };
    # };
    wifi = {
      # powersave = true;
      # scanRandMacAddress = false;
    };
  };

  # programs.hyprland = {
  #   # Install the packages from nixpkgs
  #   enable = true;
  #   # Whether to enable XWayland
  #   xwayland.enable = true;
  # };

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
