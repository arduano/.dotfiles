{ pkgs, config, ... }:
let
  ollama = pkgs.ollama.override {
    acceleration = "cuda";
    linuxPackages = config.boot.kernelPackages // {
      nvidia_x11 = config.hardware.nvidia.package;
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    ollama
  ];
}
