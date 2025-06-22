{ lib,
 stdenv,
 fetchFromGitHub,
 python,
 makeWrapper,
 zlib,
 requests,
 cryptography,
 pyserial,
 pyside6,
 arduano,
 buildPythonPackage,
 buildPythonApplication,
 setuptools
}:

let
  charachorderPy = buildPythonPackage rec {
    pname = "charachorder.py";
    version = "0.6.0";
    format = "setuptools";

    nativeBuildInputs = [ setuptools ];

    src = fetchFromGitHub {
      owner = "CharaChorder";
      repo  = "charachorder.py";
      rev   = "v${version}";
      sha256 = "1kbahc05w804a98mvgb3w3zcl0135s5pvg4msc56a54130vfc3i1";
    };
  };

in

buildPythonApplication rec {
  pname = "nexus";
  version = "0.5.3";

  format = "pyproject";

  src = fetchFromGitHub {
    owner = "CharaChorder";
    repo = "nexus";
    rev = "v${version}";
    sha256 = "1d9sqp71gr23j7rnhv92cjkk184z9q7dpa8wczsincgyy6h55y1a";
  };


  propagatedBuildInputs = [
    arduano.vinput
    requests
    cryptography
    pyserial
    charachorderPy
    pyside6
  ];

  nativeBuildInputs = [ setuptools makeWrapper arduano.pyside6-essentials ];
  buildInputs = [ zlib arduano.libvinput ];

  preBuild =
    let
      sitePackages = "$out/${python.sitePackages}";
      packageDir = "${sitePackages}/${pname}";
    in
    ''
      mkdir -p ${packageDir}/{translations,ui}

      for file in ui/*.ui; do
        NEW_NAME=$(echo $file | cut --delimiter="." --fields=1).py
        pyside6-uic $file -o ${packageDir}/$NEW_NAME
      done

      mkdir ${sitePackages}/resources_rc
      pyside6-rcc ui/resources.qrc -o ${sitePackages}/resources_rc/__init__.py

      pyside6-lupdate ui/*.ui nexus/GUI.py -ts translations/i18n_en.ts
      for file in translations/*.ts; do
        NEW_NAME=$(echo $file | cut --delimiter="." --fields=1).qm
        pyside6-lrelease $file -qm ${packageDir}/$NEW_NAME
      done
    '';

  postInstall = ''
    # Ensure libvinput is discoverable at runtime
    wrapProgram $out/bin/nexus --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ zlib arduano.libvinput ]}"
    ln -s ${arduano.libvinput}/lib/libvinput.so $out/bin/ || true
  '';


  meta = with lib; {
    description = "CharaChorder Nexus utility";
    homepage    = "https://github.com/CharaChorder/nexus";
    license     = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms   = platforms.linux;
    mainProgram = "nexus";
  };
}
