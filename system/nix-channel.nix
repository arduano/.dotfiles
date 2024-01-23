{ pkgs, ... }:

let
  nixPath = "/run/nixPath";
in
{
  systemd.tmpfiles.rules = [
    "L+ ${nixPath} - - - - ${pkgs.path}"
  ];

  nix = {
    nixPath = [ "nixpkgs=${nixPath}" ];
  };
}
