{ config, lib, pkgs, ... }: {
  imports = [
    ./roles
    ./nixChannel
    ./networking
    ./shell
    ./locale
    ./nix-ld
    ./fonts
  ];
}
