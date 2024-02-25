{ nodejs_20, pkgs, ... }:

(import ./boilerplate {
  inherit pkgs; nodejs = nodejs_20;
})
