{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [
      "8.8.8.8"
    ];
    defaultGateway = "170.64.192.1";
    defaultGateway6 = {
      address = "2400:6180:10:200::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address = "170.64.216.104"; prefixLength = 19; }
          { address = "10.49.0.5"; prefixLength = 16; }
        ];
        ipv6.addresses = [
          { address = "2400:6180:10:200::af:0"; prefixLength = 64; }
          { address = "fe80::689c:a7ff:fe73:1cfb"; prefixLength = 64; }
        ];
        ipv4.routes = [{ address = "170.64.192.1"; prefixLength = 32; }];
        ipv6.routes = [{ address = "2400:6180:10:200::1"; prefixLength = 128; }];
      };
      eth1 = {
        ipv4.addresses = [
          { address = "10.126.0.2"; prefixLength = 20; }
        ];
        ipv6.addresses = [
          { address = "fe80::cc7e:98ff:fee6:9631"; prefixLength = 64; }
        ];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="6a:9c:a7:73:1c:fb", NAME="eth0"
    ATTR{address}=="ce:7e:98:e6:96:31", NAME="eth1"
  '';
}
