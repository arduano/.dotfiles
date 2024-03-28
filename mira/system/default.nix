{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "mira";
  networking.domain = "";

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  # TODO: Adjust
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [ ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBNGcAJ67fESu8qzBS284/HyzLB4MyiCsGXe+bxfMisY1qRSGtEV4x/4t4NleKcjRudsooN9fgOVU1Shej7/OGFPbe0YC8ceuMlPI4kjSfpGZS63pGUCx+FYPiHYoeprC0EKR9JsbYJcivZSjuN8jIm7izxD0APp5i/8cpl5G0le/xQMZZZfjElB6zXT5+SMxAJSJQA5s+ZYSjGcoOrr88xgboSSbFJMdMEynLPfJbDQB1CldR9M+tYdokt/dZs9L818MGS53OmjaIQSj/4vPvKLR5OHfld2AEW5DnMrEL3KzO5FF4gAs+e9Iqhs/PH8vBt7q1v8ypzC9rhuy3agn+Y4TVtauzECm6NsWaw5/S1J0EbK5hkDHnr6tOP6BaUubt5G5wzbcHnh1kRzg0miQnp1Y+UJEFcbikvgq6yTHot2RHMDmveydelL2iuHEPT3XTd82jDyHLp1Z23C/eDTn339QrHaC/Kv9Jn9VT2wkMZ6Xxx5tE3F5KXhpT+DCeRb0= arduano@home-nas'' ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC65VNln+GZuioJe5AOjbKEtFHrlx/lHTraiEFLnlrimvvFFYx8VtNyGupBJWzilb+OmY6KlJAS9EfyOu8WLRfkELXc7ePAAMu/jP4wmsUPA3yfLEUWOTg+LKthI9JZ07WwzpzYsU3Edw0K4FSpxyKLm1mtDE/OAuqR0TtyXPV7GldSb1xljPHzDhspnT9Ak1e2PK59GpXs/utw/1KlChJeiK0X71Ba4AiT0Ii4auYWuROtdvFNZl1tELqP9o6+giSVNb00SA7En9XBk4ouc5ueSwETBi5cjLJ7M/sWInKfd2O9W5KzxuJfThmrc3z1RZLVGsCstjVDDTps/hub4SmV leoni@DESKTOP-2M6EOST'' ];

  arduano.shell.enable = true;
  arduano.locale.enable = true;


  environment.systemPackages = with pkgs.arduano.groups;
    shell-essentials;

  virtualisation.docker.enable = true;

  users.users.arduano = {
    isNormalUser = true;
    createHome = true;
    description = "arduano";
    extraGroups = [ "networkmanager" "wheel" "fuse" "docker" ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;


  system.stateVersion = "23.11";
}
