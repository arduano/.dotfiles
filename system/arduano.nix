{ ... }: {
  services.arduano.sunshine.enable = true;

  arduano.syncNixChannel.enable = true;
  arduano.vscode-server.enable = true;

  arduano.networking.enable = true;

  # networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp5s0.ipv4.addresses = [{
    address = "192.168.1.52";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "192.168.1.1" "1.1.1.1" "1.0.0.1" ];
}
