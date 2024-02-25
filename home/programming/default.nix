{ config, pkgs, inputs, ... }:


{
  imports = [
  ];

  programs.git = {
    enable = true;
    userName = "arduano";
    userEmail = "leonid.shchurov@gmail.com";
    extraConfig = {
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
}
