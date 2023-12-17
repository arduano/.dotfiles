{ config, pkgs, inputs, lib, runtimePath, ... }:

{
  home.file.".config/powermanagementprofilesrc".source =
    config.lib.file.mkOutOfStoreSymlink
    (runtimePath ./powermanagementprofilesrc);

  home.file.".config/kscreenlockerrc".source =
    config.lib.file.mkOutOfStoreSymlink
    (runtimePath ./kscreenlockerrc);
}
