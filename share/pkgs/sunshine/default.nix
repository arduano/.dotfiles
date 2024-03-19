{ sunshine
, lib
, fetchFromGitHub
, buildNpmPackage
, ...
}:
sunshine.overrideAttrs (oldAttrs: rec {
  pname = "sunshine";
  version = "0.22.2";

  src = fetchFromGitHub {
    owner = "LizardByte";
    repo = "Sunshine";
    rev = "v${version}";
    sha256 = "sha256-So8fX0XQoW2cdTWWENoE07EU6e8vvjeTpizLoaDTjeg=";
    fetchSubmodules = true;
  };

  patches = [
    ./dont-build-webui.patch
    ./screens.patch
  ];

  cmakeFlags = [
    "-Wno-dev"
    # upstream tries to use systemd and udev packages to find these directories in FHS; set the paths explicitly instead
    (lib.cmakeFeature "UDEV_RULES_INSTALL_DIR" "lib/udev/rules.d")
    (lib.cmakeFeature "SYSTEMD_USER_UNIT_INSTALL_DIR" "lib/systemd/user")
  ];

  postPatch = ''
    # remove upstream dependency on systemd and udev
    substituteInPlace cmake/packaging/linux.cmake \
      --replace-fail 'find_package(Systemd)' "" \
      --replace-fail 'find_package(Udev)' ""
    substituteInPlace packaging/linux/sunshine.desktop \
      --subst-var-by PROJECT_NAME 'Sunshine' \
      --subst-var-by PROJECT_DESCRIPTION 'Self-hosted game stream host for Moonlight' \
      --replace-fail '/usr/bin/env systemctl start --u sunshine' 'sunshine'
  '';
})
