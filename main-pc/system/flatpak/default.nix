{ config, pkgs, inputs, ... }:

{
  services.flatpak = {
    enable = true;

    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };

    packages =
      [ ];
  };
}
