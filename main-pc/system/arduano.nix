{ pkgs, ... }: {
  arduano.sunshine.enable = true;

  arduano.syncNixChannel.enable = true;

  # arduano.vscode-server.enable = true;
  # services.vscode-server.enable = true;

  arduano.networking.enable = true;
  arduano.shell.enable = true;
  arduano.portals.enable = true;

  # networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp5s0.ipv4.addresses = [{
    address = "192.168.1.52";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "192.168.1.1" "1.1.1.1" "1.0.0.1" ];

  environment.systemPackages = with pkgs.arduano.groups;
    build-essentials ++ shell-essentials ++ shell-useful ++ shell-programming ++ gui-root ++ gui-root;


  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
