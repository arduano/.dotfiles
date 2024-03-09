{ config, lib, pkgs, ... }: {
  imports = [
    ./sunshine
    ./nixChannel
    ./vscode
    ./networking
    ./shell
    ./portals
    ./locale
  ];
}
