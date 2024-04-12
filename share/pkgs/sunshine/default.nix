{ sunshine
, ...
}:
sunshine.overrideAttrs (oldAttrs: rec {
  patches = oldAttrs.patches ++ [
    ./screens.patch
  ];

  cmakeFlags = oldAttrs.cmakeFlags ++ [
    "-DSUNSHINE_ENABLE_DRM=OFF"
  ];
})
