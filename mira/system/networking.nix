{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [
      "8.8.8.8"
    ];
    defaultGateway = "170.64.224.1";
    defaultGateway6 = {
      address = "2400:6180:10:200::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address = "170.64.226.96"; prefixLength = 20; }
          { address = "10.49.0.5"; prefixLength = 16; }
        ];
        # ipv6.addresses = [
        #   { address = "2400:6180:10:200::59:0"; prefixLength = 64; }
        #   { address = "fe80::3c2b:abff:feaa:eab"; prefixLength = 64; }
        # ];
        ipv4.routes = [{ address = "170.64.224.1"; prefixLength = 32; }];
        # ipv6.routes = [{ address = "2400:6180:10:200::1"; prefixLength = 128; }];
      };
      eth1 = {
        ipv4.addresses = [
          { address = "10.126.0.2"; prefixLength = 20; }
        ];
        # ipv6.addresses = [
        #   { address = "fe80::1017:ceff:fee8:411c"; prefixLength = 64; }
        # ];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="3e:2b:ab:aa:0e:ab", NAME="eth0"
    ATTR{address}=="12:17:ce:e8:41:1c", NAME="eth1"
  '';
}
