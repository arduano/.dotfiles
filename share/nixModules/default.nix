{ config, lib, pkgs, ... }: {
  imports = [
    ./sunshine
    ./nixChannel
    ./vscode
    ./networking
  ];
}
