{ lib, python3Packages, fetchFromGitHub, arduano }:

python3Packages.buildPythonPackage rec {
  pname = "vinput";
  version = "0.6.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "slendidev";
    repo = "libvinput.py";
    rev = "v${version}";
    sha256 = "0ihhca1bql3bzhp6a1a8jyhq0ygp72ad7rqbqppxrrvhnyqhvapk";
  };

  nativeBuildInputs = with python3Packages; [ setuptools wheel arduano.libvinput ];

  propagatedBuildInputs = [ arduano.libvinput ];

  # Ensure the C shared library is discoverable during build-time checks
  preCheck = ''
    export LD_LIBRARY_PATH=${lib.makeLibraryPath [ arduano.libvinput ]}
  '';

  # Ensure it is also discoverable for downstream consumers at runtime
  preFixup = ''
    makeWrapperArgs+=(--prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ arduano.libvinput ]})
  '';

  # Place the shared library where the vinput Python code expects it
  postInstall = ''
    vinput_lib=$(find ${arduano.libvinput}/lib -name "libvinput.so*" | head -n1)
    target_dir="$out/${python3Packages.python.sitePackages}/vinput/lib"
    mkdir -p "$target_dir"
    cp "$vinput_lib" "$target_dir/libvinput.so.dat"
  '';

  pythonImportsCheck = [ "vinput" ];

  meta = with lib; {
    description = "Python bindings for the libvinput library";
    homepage = "https://github.com/slendidev/libvinput.py";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ ];
  };
}
