{ config, pkgs, inputs, ... }:

let
  buildLlvm = with pkgs;  { version, sha256 }: stdenv.mkDerivation {
    name = "llvm-${version}";
    src = fetchurl {
      url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-${version}/llvm-project-${version}.src.tar.xz";
      inherit sha256;
    };

    nativeBuildInputs = [ cmake ninja python3 ];

    configurePhase = ''
      mkdir build_release
      cmake -S llvm -B build_release -G Ninja -DLLVM_ENABLE_PROJECTS='llvm' -DLLVM_TARGETS_TO_BUILD='X86' -DCMAKE_BUILD_TYPE=Release
    '';

    buildPhase = ''
      cmake --build build_release
    '';

    installPhase = ''
      cmake --install build_release --prefix $out
    '';
  };

  llvm17 = buildLlvm {
    version = "17.0.6";
    sha256 = "sha256-WKiBjGDmYnBk8xLb9GwC2ZSZVlWDQJOLcc9zGti8CBM=";
  };
in
{
  environment.variables = {
    LLVM_SYS_170_PREFIX = "${llvm17}";
  };
}
