{ config, pkgs, inputs, ... }:

let
  sunshine = (
    (import ./build.nix) pkgs // {
      cudaSupport = true;
      stdenv = pkgs.cudaPackages.backendStdenv;
    }
  );
in
{
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${sunshine}/bin/sunshine";
  };

  # Requires to simulate input
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';

  systemd.user.services.sunshine = {
    enable = true;
    description = "Starts Sunshine";
    wantedBy = [ "graphical-session.target" ];
    startLimitIntervalSec = 500;
    startLimitBurst = 5;
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = 5;
      ExecStart = "${config.security.wrapperDir}/sunshine ${./sunshine.conf}";
    };
  };

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
}
