{ sunshine
, ...
}:
sunshine.overrideAttrs (oldAttrs: rec {
  patches = oldAttrs.patches ++ [
    ./screens.patch
  ];
})
