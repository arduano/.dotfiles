{ inputs }:
final: prev: {
  arduano = final.callPackage ./pkgs/default.nix { };

  # Keep OpenCV on cache-friendly CPU builds; CUDA-enabled OpenCV tends to miss
  # substitutes and pulls large local rebuilds into otherwise routine switches.
  opencv = prev.opencv.override {
    enableCuda = false;
  };
  opencv4 = prev.opencv4.override {
    enableCuda = false;
  };

  brave = prev.brave.overrideAttrs (old: {
    postFixup = (old.postFixup or "") + ''
      # MangoHud injection caused Brave GPU/compositor rendering corruption on
      # Plasma Wayland/NVIDIA. Keep the workaround scoped to Brave.
      wrapProgram $out/bin/brave \
        --unset MANGOHUD
    '';
  });

  zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
}
