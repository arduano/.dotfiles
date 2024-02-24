{ sunshine
, ...
}:
sunshine.overrideAttrs (oldAttrs: {
  patches = [
    ./screens.patch
  ];
})