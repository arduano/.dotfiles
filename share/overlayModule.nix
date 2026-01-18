{ inputs, ... }:
{
  nixpkgs.overlays = [
    (import ./overlay.nix { inherit inputs; })
  ];
}
