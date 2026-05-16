{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.arduano.programming;
in
{
  options = {
    arduano.programming.enable = mkEnableOption "Enable programming utils";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      signing.format = "ssh";
      settings = {
        user.name = "arduano";
        user.email = "leonid.shchurov@gmail.com";
        pull.rebase = "false";
        gpg.format = "ssh";
        commit.gpgsign = "true";
        user.signingkey = "/home/arduano/.ssh/github.pub";
        fetch.writeCommitGraph = "true";
      };
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.bun.enable = true;
  };
}
