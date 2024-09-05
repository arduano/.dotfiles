final: prev: {
  arduano = final.callPackage ./pkgs/default.nix { };

  # Disable cuda in certain packages for better build cache
  opencv = prev.opencv.override {
    enableCuda = false;
  };
  opencv4 = prev.opencv4.override {
    enableCuda = false;
  };
}
