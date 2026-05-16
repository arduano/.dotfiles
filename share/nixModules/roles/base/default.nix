{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.arduano.roles.base;
in
{
  options.arduano.roles.base = {
    enable = mkEnableOption "base host defaults";
    createUserHomes = mkEnableOption "create homes for common users";
    arduanoExtraGroups = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Extra groups for the arduano user.";
    };
    recoveryExtraGroups = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Extra groups for the recovery user.";
    };
  };

  config = mkIf cfg.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    users.users.arduano = {
      isNormalUser = true;
      createHome = mkIf cfg.createUserHomes true;
      description = "arduano";
      extraGroups = [ "networkmanager" "wheel" "fuse" ] ++ cfg.arduanoExtraGroups;
    };

    users.users.recovery = {
      isNormalUser = true;
      createHome = mkIf cfg.createUserHomes true;
      description = "recovery";
      extraGroups = [ "networkmanager" "wheel" "fuse" ] ++ cfg.recoveryExtraGroups;
    };
  };
}
