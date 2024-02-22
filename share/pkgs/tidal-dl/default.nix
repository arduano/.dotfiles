{ lib, fetchFromGitHub, python3 }:
let


in
python3.pkgs.buildPythonApplication rec {
  pname = "Tidal-Media-Downloader";
  version = "8352f0f";

  tidalDlSrc = fetchFromGitHub
    {
      owner = "yaronzz";
      repo = pname;
      rev = version;
      sha256 = "sha256-w17b584HrU8ZfRO9T9UCzOxtNGnhSmdHfSLh2VLXp0U=";

      postFetch = ''
        cd $out
        patch -p1 < ${./setup.patch}
        patch -p1 < ${./init.patch}
      '';
    };

  src = "${tidalDlSrc}/TIDALDL-PY";

  nativeBuildInputs = [
  ];

  buildInputs = [
  ];

  propagatedBuildInputs = with python3.pkgs; [
    aigpy
  ];

  doCheck = false;

  meta = with lib; {
    mainProgram = "tidal-dl";
  };
}
