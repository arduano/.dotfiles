{ config, pkgs, inputs, lib, ... }:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    (import ./share/overlayModule.nix)
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_16.override {
  #   argsOverride = rec {
  #     src = pkgs.fetchgit {
  #       url = "https://evilpiepirate.org/git/bcachefs.git";
  #       rev = "c0d938c16b674bfe9e710579344653b703b92a49";
  #       sha256 = "sha256-/UcbEeZ7UFQhaAsSHQtEgjv5vude+dMsr0/wS3fiXVk=";
  #     };
  #     version = "6.16-bcachefs";
  #     modDirVersion = "6.16.0-rc6";
  #   };
  # });

  users.users.nixos = {
    initialHashedPassword = lib.mkForce null;
    initialPassword = "nixos";
  };

  boot.supportedFilesystems = lib.mkForce [ "btrfs" "cifs" "f2fs" "jfs" "ntfs" "reiserfs" "vfat" "xfs" "bcachefs" ];

  environment.systemPackages = with pkgs; [ bcachefs-tools ] ++ pkgs.arduano.groups.shell-essentials;
}
