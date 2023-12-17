{ config, pkgs, inputs, ... }:

{
  services.flatpak = {
    enable = true;

    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };

    # They don't get automatically uninstalled when removed from the list
    packages =
      [ "org.signal.Signal" "com.microsoft.Edge" "com.plexamp.Plexamp" ];
  };
}
