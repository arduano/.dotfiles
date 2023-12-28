{ config, pkgs, inputs, ... }:

let nixPath = "/etc/nixPath";

in
{
  systemd.tmpfiles.rules = [
    "L+ ${nixPath} - - - - ${pkgs.path}"
  ];

  nix = {
    nixPath = [ "nixpkgs=${nixPath}" ];
  };
}
