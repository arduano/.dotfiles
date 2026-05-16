{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nix-openclaw.overlays.default
    (import ./overlay.nix { inherit inputs; })
  ];
}
