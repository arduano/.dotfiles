{ config, pkgs, inputs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 45754 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
