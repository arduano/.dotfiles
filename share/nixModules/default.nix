{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./roles
    ./work-vm
    ./nixChannel
    ./networking
    ./shell
    ./locale
    ./nix-ld
    ./fonts
  ];
}
