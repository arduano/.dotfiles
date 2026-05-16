{ sunshine
, ...
}:
sunshine.overrideAttrs (oldAttrs: rec {
  # Local display enumeration patch plus DRM capture disabled. Sunshine is run
  # through the NixOS module wrapper when enabled, and this avoids the DRM path
  # that has been unreliable on this host's NVIDIA/Wayland setup.
  patches = [
    ./screens.patch
  ];

  cmakeFlags = oldAttrs.cmakeFlags ++ [
    "-DSUNSHINE_ENABLE_DRM=OFF"
  ];
})
