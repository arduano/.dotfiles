{ pkgs, config, ... }:
let
  ollama = pkgs.ollama.override {
    acceleration = "cuda";
  };
in
{
  environment.systemPackages = with pkgs; [
    ollama
  ];
}
