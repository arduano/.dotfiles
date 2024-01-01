{ config, pkgs, inputs, ... }:

let nixPath = "/tmp/nixPath";

in
{
  systemd.tmpfiles.rules = [
    "L+ ${nixPath} - - - - ${pkgs.path}"
  ];

  nix = {
    nixPath = [ "nixpkgs=${nixPath}" ];
  };
}
