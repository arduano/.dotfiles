{ inputs }:
final: prev:
let
  # OpenClaw uses Node's built-in SQLite support at runtime. Node 22.23.1
  # embeds SQLite 3.51.2, which OpenClaw rejects because of the upstream WAL
  # reset corruption bug. Apply the OpenClaw overlay only to a private package
  # scope where its nodejs_22 dependency resolves to the safe Node 24 release.
  # This prevents OpenClaw's pinned build tools (notably pnpm_11) from replacing
  # the corresponding packages in nixpkgs for unrelated applications.
  openclawRuntimePkgs =
    inputs.nixpkgs-openclaw-runtime.legacyPackages.${prev.stdenv.hostPlatform.system};
  scopedOpenclawPkgs = prev // {
    callPackage = prev.lib.callPackageWith scopedOpenclawPkgs;
    nodejs_22 = openclawRuntimePkgs.nodejs_24;
  };
  scopedOpenclaw = inputs.nix-openclaw.overlays.default scopedOpenclawPkgs scopedOpenclawPkgs;
in
{
  arduano = final.callPackage ./pkgs/default.nix { };

  inherit (scopedOpenclaw)
    openclaw
    openclaw-gateway
    openclawPackages
    openclawRuntimePlugins
    ;

  # OpenCode releases faster than nixpkgs. Keep the generic `pkgs.opencode`
  # name pinned to our verified upstream package so shared programming-tool
  # lists do not silently fall back to an older nixpkgs version.
  opencode = final.arduano.opencode-latest;

  # Keep OpenCV on cache-friendly CPU builds; CUDA-enabled OpenCV tends to miss
  # substitutes and pulls large local rebuilds into otherwise routine switches.
  opencv = prev.opencv.override {
    enableCuda = false;
  };
  opencv4 = prev.opencv4.override {
    enableCuda = false;
  };

  brave = prev.brave.overrideAttrs (old: {
    postFixup = (old.postFixup or "") + ''
      # MangoHud injection caused Brave GPU/compositor rendering corruption on
      # Plasma Wayland/NVIDIA. Keep the workaround scoped to Brave.
      wrapProgram $out/bin/brave \
        --unset MANGOHUD
    '';
  });

  zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
}
