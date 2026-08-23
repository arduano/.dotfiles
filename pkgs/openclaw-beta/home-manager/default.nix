{
  inputs,
  lib,
  ...
}:
{
  imports = [
    (lib.mkRemovedOptionModule [
      "programs"
      "openclaw"
      "firstParty"
    ] "Use programs.openclaw.bundledPlugins.<name>.enable/config.")
    (lib.mkRemovedOptionModule [
      "programs"
      "openclaw"
      "plugins"
    ] "Use programs.openclaw.customPlugins.")
    ./options.nix
    "${inputs.nix-openclaw}/nix/modules/home-manager/openclaw/config.nix"
  ];
}
