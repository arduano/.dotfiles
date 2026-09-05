{ lib
, stdenvNoCC
, fetchurl
, autoPatchelfHook
, makeWrapper
, ripgrep
, versionCheckHook
,
}:

let
  version = "1.18.29";

  source = {
    x86_64-linux = {
      url = "https://github.com/anomalyco/opencode/releases/download/v${version}/opencode-linux-x64.tar.gz";
      hash = "sha256-6oALf/ViJrcJUhJsn8HiUXykxLVoL9nT+eh0SWl6EZQ=";
    };
  }.${stdenvNoCC.hostPlatform.system} or (throw "opencode-latest: unsupported platform ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "opencode";
  inherit version;

  src = fetchurl source;
  sourceRoot = ".";

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  # Bun standalone executables carry application data in sections that the
  # generic Nix strip hook can remove, producing a subtly corrupted binary.
  dontStrip = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 opencode $out/libexec/opencode
    makeWrapper $out/libexec/opencode $out/bin/opencode \
      --prefix PATH : ${lib.makeBinPath [ ripgrep ]} \
      --set OPENCODE_DISABLE_AUTOUPDATE true

    runHook postInstall
  '';

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;
  versionCheckProgramArg = "--version";

  meta = {
    description = "AI coding agent built for the terminal (latest upstream release)";
    homepage = "https://opencode.ai/";
    changelog = "https://github.com/anomalyco/opencode/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "opencode";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
