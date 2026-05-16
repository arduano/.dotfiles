{ inputs }:
final: prev: {
  arduano = final.callPackage ./pkgs/default.nix { };

  # Disable cuda in certain packages for better build cache
  opencv = prev.opencv.override {
    enableCuda = false;
  };
  opencv4 = prev.opencv4.override {
    enableCuda = false;
  };

  brave = prev.brave.overrideAttrs (old: {
    postFixup = (old.postFixup or "") + ''
      wrapProgram $out/bin/brave \
        --unset MANGOHUD
    '';
  });

  zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
}
