{ autoPatchelfHook
, buildPythonPackage
, fetchurl
, lib
, shiboken6
, pyside6

  # libraries
, gtk3
, libxkbcommon
, mysql80
, postgresql
, qt6
, unixODBC
, makeWrapper
}:

buildPythonPackage rec {
  pname = "pyside6-essentials";
  inherit (shiboken6) version;
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/59/6a/ea0db68d40a1c487fd255634896f4e37b6560e3ef1f57ca5139bf6509b1f/PySide6_Essentials-${version}-cp39-abi3-manylinux_2_28_x86_64.whl";
    sha256 = "sha256-5dpIiD8AbGIG74WHTbdN3rzfabAoG9TxZCscWsHVSuo=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    gtk3 # libgtk-3.so.0 and more
    libxkbcommon # libxkbcommon.so.0
    mysql80 # libmysqlclient.so.21
    postgresql.lib # libpq.so.5
    qt6.full # libGL.so.1, and more
    unixODBC # libodbc.so.2
  ];

  dependencies = [
    shiboken6
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libmimerapi.so"
    "libQt6EglFsKmsGbmSupport.so.6"
  ]; # not in nixpkgs yet

  meta = with lib; {
    description = "Python bindings for Qt (Essentials)";
    homepage = "https://www.pyside.org";
    license = licenses.lgpl3; # unsure which LGPL version
    maintainers = with maintainers; [ getpsyched ];
  };
}
