{ config, pkgs, inputs, lib, ... }:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    (import ./share/overlayModule.nix)
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_8.override {
    argsOverride = rec {
      src = pkgs.fetchgit {
        url = "https://evilpiepirate.org/git/bcachefs.git";
        rev = "2e92d26b25432ec3399cb517beb0a79a745ec60f";
        sha256 = "sha256-Su9ogVaASFfBSqp1VIggWp+IYAqjRDtCWdZLW69JVkE=";
      };
      version = "6.8.1-bcachefs";
      modDirVersion = "6.8.0-rc6";
    };
  });

  boot.supportedFilesystems = lib.mkForce [ "btrfs" "cifs" "f2fs" "jfs" "ntfs" "reiserfs" "vfat" "xfs" "bcachefs" ];

  environment.systemPackages = with pkgs; [ bcachefs-tools ] ++ pkgs.arduano.groups.shell-essentials;
}
