{ config, pkgs, inputs, ... }:

{
  boot.bcache.enable = true;
  boot.initrd.services.bcache.enable = true;
}
