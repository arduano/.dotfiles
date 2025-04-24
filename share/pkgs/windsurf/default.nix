{ stdenv
, stdenvNoCC
, lib
, callPackage
, fetchurl
, nixosTests
, srcOnly
, isInsiders ? false
# sourceExecutableName is the name of the binary in the source archive over
# which we have no control and it is needed to run the insider version as
# documented in https://wiki.nixos.org/wiki/Visual_Studio_Code#Insiders_Build
# On MacOS the insider binary is still called code instead of code-insiders as
# of 2023-08-06.
, commandLineArgs ? ""
, useVSCodeRipgrep ? stdenv.hostPlatform.isDarwin
}:

let
  inherit (stdenv.hostPlatform) system;
  throwSystem = throw "Unsupported system: ${system}";

  plat = {
    x86_64-linux = "linux-x64";
    x86_64-darwin = "darwin";
    aarch64-linux = "linux-arm64";
    aarch64-darwin = "darwin-arm64";
    armv7l-linux = "linux-armhf";
  }.${system} or throwSystem;

  archive_fmt = if stdenv.hostPlatform.isDarwin then "zip" else "tar.gz";

  sourceExecutableName = "windsurf";
in
  callPackage ./generic.nix rec {
    # Please backport all compatible updates to the stable release.
    # This is important for the extension ecosystem.
    version = "1.95.3";
    pname = "windsurf";

    # This is used for VS Code - Remote SSH test
    rev = "f1a4fb101478ce6ec82fe9627c43efbf9e98c813";

    executableName = "windsurf";
    longName = "Windsurf";
    shortName = "Windsurf";
    inherit commandLineArgs useVSCodeRipgrep sourceExecutableName;

    src = fetchurl {
      url = "https://windsurf-stable.codeiumdata.com/linux-x64/stable/43976ecab7354ba352849517e15779fe8a4eff88/Windsurf-linux-x64-1.3.9.tar.gz";
      sha256 = "sha256-AigJmjkSjLIbHNh1FtdKwb+qHdgB9H/rOmex2+9zZcc=";
    };

    # We don't test vscode on CI, instead we test vscodium
    tests = {};

    sourceRoot = "";

    tests = { inherit (nixosTests) vscode-remote-ssh; };

    # updateScript = ./update-vscode.sh;

    meta = with lib; {
      description = ''
        Open source source code editor developed by Microsoft for Windows,
        Linux and macOS
      '';
      mainProgram = "windsurf";
      longDescription = ''
        Open source source code editor developed by Microsoft for Windows,
        Linux and macOS. It includes support for debugging, embedded Git
        control, syntax highlighting, intelligent code completion, snippets,
        and code refactoring. It is also customizable, so users can change the
        editor's theme, keyboard shortcuts, and preferences
      '';
      homepage = "https://code.visualstudio.com/";
      downloadPage = "https://code.visualstudio.com/Updates";
      license = licenses.mit;
      maintainers = with maintainers; [ eadwu synthetica bobby285271 johnrtitor ];
      platforms = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux" "armv7l-linux" ];
    };
  }