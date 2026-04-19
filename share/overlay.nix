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
      # Point Brave at the host’s Vulkan loader
      wrapProgram $out/bin/brave \
        --prefix LD_LIBRARY_PATH : ${prev.vulkan-loader}/lib \
        --unset MANGOHUD \
        --add-flags "--enable-gpu --use-vulkan=deferred --enable-features=Vulkan,WebGPU"
    '';
  });
}
