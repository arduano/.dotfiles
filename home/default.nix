{ config, pkgs, inputs, ... }:

{
  imports = [ ./desktop ./kde ./power ./programming ./arduano.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "arduano";
  home.homeDirectory = "/home/arduano";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    (pkgs.writeShellScriptBin "switch-home" ''
      cd ~/.dotfiles &&
        nix flake lock --update-input arduano-modules . &&
        home-manager switch -L -v --flake ".?submodules=1" &&
        xdg-desktop-menu forceupdate
    '')
    (pkgs.writeShellScriptBin "switch-system" ''
      cd ~/.dotfiles &&
        nix flake lock --update-input arduano-modules . &&
        sudo nixos-rebuild switch -L -v --flake ".?submodules=1" &&
        xdg-desktop-menu forceupdate
    '')
    (pkgs.writeShellScriptBin "switch-all" ''
      switch-system &&
        switch-home
    '')

    (pkgs.writeShellScriptBin "nrun" ''
      # Run the first arg, with the rest of the args as arguments, in a nix shell
      NIXPKGS_ALLOW_UNFREE=1 nix run --impure "nixpkgs#$1" -- ''${@:2}
    '')

    (pkgs.writeShellScriptBin "run-full-os-gc" ''
      sudo nix-env --delete-generations +1 &&
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system +1 &&
        nix-env --delete-generations +1 &&
        home-manager expire-generations "-0 days" &&
        nix store gc &&
        switch-system &&
        switch-home
    '')

    firefox
    steam
    vlc
    kate
    vscode-fhs
    flameshot
    konversation
    vesktop
    libreoffice
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/arduano/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
