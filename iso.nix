{ config, pkgs, inputs, ... }:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    (import ./share/overlayModule.nix)
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "bcachefs" ];

  environment.systemPackages = with pkgs; [ bcachefs-tools ] ++ pkgs.arduano.groups.shell-essentials;
}
