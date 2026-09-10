{
  lib,
  stdenv,
  buildNpmPackage,
  makeWrapper,
  writeText,
  nodejs,
  nixOpenclawSrc,
}:

let
  version = "2026.9.1";
  # OpenClaw 2026.9.1 moved plugin realpath lookups into its shared cache.
  patchNpmDistScript = writeText "patch-openclaw-npm-dist.mjs" (
    builtins.replaceStrings
      [
        "isNixStorePluginRoot(params.rootDir, params.realpathCache)"
        "safeRealpathSync(params.rootDir, params.realpathCache)"
        "safeRealpathSync"
      ]
      [
        "isNixStorePluginRoot(params.rootDir)"
        "pluginCacheRealpathSync(params.rootDir)"
        "pluginCacheRealpathSync"
      ]
      (builtins.readFile "${nixOpenclawSrc}/nix/scripts/patch-openclaw-npm-dist.mjs")
  );
  buildNpmPackageForOpenClaw = buildNpmPackage.override {
    inherit nodejs;
  };
in
buildNpmPackageForOpenClaw {
  pname = "openclaw-gateway";
  inherit version;

  src = ./npm;
  npmDepsHash = "sha256-lyfePSNUF50Eep9C2ImSnsixOpyUJRtN3tLoaCUGMJ4=";
  dontNpmBuild = true;
  makeCacheWritable = true;

  npmInstallFlags = [
    "--omit=dev"
    "--ignore-scripts"
    "--legacy-peer-deps"
    "--install-strategy=nested"
  ];

  nativeBuildInputs = [ makeWrapper ];

  env = {
    NODE_BIN = "${nodejs}/bin/node";
    OPENCLAW_NPM_PACKAGE_ROOT = "node_modules/openclaw";
    OPENCLAW_PATCH_NPM_DIST_SCRIPT = "${patchNpmDistScript}";
    STDENV_SETUP = "${stdenv}/setup";
  };

  installPhase = ''
    ${nixOpenclawSrc}/nix/scripts/openclaw-gateway-npm-install.sh

    # The nested npm install leaves some ordinary runtime dependencies at the
    # wrapper project's top level. Copy those into the gateway closure, while
    # keeping external OpenClaw plugins in OpenClaw's managed install area so
    # their official-install provenance is preserved.
    for packageEntry in node_modules/* node_modules/@*/*; do
      [ -f "$packageEntry/package.json" ] || continue
      case "$packageEntry" in
        node_modules/openclaw|node_modules/@openclaw/ai) continue ;;
      esac
      relativePath="''${packageEntry#node_modules/}"
      mkdir -p "$out/lib/openclaw/node_modules/$(dirname "$relativePath")"
      rm -rf "$out/lib/openclaw/node_modules/$relativePath"
      cp -R "$packageEntry" "$out/lib/openclaw/node_modules/$relativePath"
    done

    # The npm tarball carries source-checkout markers even though this is an
    # immutable runtime package. Leaving this marker triggers a false plugin
    # dependency warning because Nix deliberately uses npm's nested layout.
    # Without that marker, OpenClaw prefers dist-runtime over the complete
    # dist/extensions tree, but nix-openclaw's staged dist-runtime lacks the
    # shared root chunks imported by provider plugins. Remove both the
    # marker and incomplete fallback so OpenClaw selects dist/extensions.
    rm -f "$out/lib/openclaw/pnpm-workspace.yaml"
    rm -rf "$out/lib/openclaw/dist-runtime"
  '';

  dontFixup = true;
  dontStrip = true;
  dontPatchShebangs = true;

  passthru = {
    beta = false;
    inherit version;
  };

  meta = with lib; {
    description = "OpenClaw stable gateway";
    homepage = "https://github.com/openclaw/openclaw";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "openclaw";
  };
}
