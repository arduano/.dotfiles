{ sunshine
, ...
}:
sunshine.overrideAttrs (oldAttrs: rec {
  patches = [
    ./screens.patch
  ];

  cmakeFlags = oldAttrs.cmakeFlags ++ [
    "-DSUNSHINE_ENABLE_DRM=OFF"
  ];
})
