{ ... }: {
  services.caddy = {
    enable = true;
    virtualHosts."maketen.arduano.io".extraConfig = ''
      reverse_proxy localhost:8863
    '';
  };
}
