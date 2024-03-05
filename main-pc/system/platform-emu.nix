{ config, pkgs, inputs, ... }:

{
  virtualisation.docker.enable = true;
  services.qemuGuest.enable = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  environment.systemPackages = with pkgs; [
    qemu_full
  ];
}
