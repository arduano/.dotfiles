final: prev: {
  arduano = final.callPackage ./pkgs/default.nix { };

  # TODO: https://github.com/NixOS/nixpkgs/issues/288064
  libgit2 = prev.libgit2.overrideAttrs (old: {
    doCheck = false;
  });
}
