{ lib
, stdenv
, fetchFromGitHub
, autoPatchelfHook
, makeWrapper
, buildNpmPackage
, cmake
, avahi
, libevdev
, libpulseaudio
, xorg
, openssl
, libopus
, boost
, pkg-config
, libdrm
, wayland
, libffi
, libcap
, mesa
, curl
, pcre
, pcre2
, libuuid
, libselinux
, libsepol
, libthai
, libdatrie
, libxkbcommon
, libepoxy
, libva
, libvdpau
, libglvnd
, numactl
, amf-headers
, intel-media-sdk
, svt-av1
, vulkan-loader
, libappindicator
, libnotify
, config
, cudaSupport ? config.cudaSupport
, cudaPackages ? { }
, ...
}:
stdenv.mkDerivation rec {
  pname = "sunshine";
  version = "0.21.0-fix";

  src = fetchFromGitHub {
    owner = "arduano";
    repo = "Sunshine";
    rev = "v${version}";
    sha256 = "sha256-/koesQsJAQ9njnuj7xLg9CIU06X/94OF3yWvUajSkyU=";
    fetchSubmodules = true;
  };

  # fetch node_modules needed for webui
  ui = buildNpmPackage {
    inherit src version;
    pname = "sunshine-ui";
    npmDepsHash = "sha256-O9aUCM9XeI5UYXh/w9KCtFOCW54ckqzGt4j0bZGINkI=";

    dontNpmBuild = true;

    installPhase = ''
      mkdir -p $out
      cp -r node_modules $out/
    '';
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    autoPatchelfHook
    makeWrapper
  ] ++ lib.optionals cudaSupport [
    cudaPackages.autoAddOpenGLRunpathHook
  ];

  buildInputs = [
    avahi
    libevdev
    libpulseaudio
    xorg.libX11
    xorg.libxcb
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXtst
    xorg.libXi
    openssl
    libopus
    boost
    libdrm
    wayland
    libffi
    libevdev
    libcap
    libdrm
    curl
    pcre
    pcre2
    libuuid
    libselinux
    libsepol
    libthai
    libdatrie
    xorg.libXdmcp
    libxkbcommon
    libepoxy
    libva
    libvdpau
    numactl
    mesa
    amf-headers
    svt-av1
    libappindicator
    libnotify
  ] ++ lib.optionals cudaSupport [
    cudaPackages.cudatoolkit
  ] ++ lib.optionals stdenv.isx86_64 [
    intel-media-sdk
  ];

  runtimeDependencies = [
    avahi
    mesa
    xorg.libXrandr
    xorg.libxcb
    libglvnd
  ];

  cmakeFlags = [
    "-Wno-dev"
  ];

  postPatch = ''
    # fix hardcoded libevdev path
    substituteInPlace cmake/compile_definitions/linux.cmake \
      --replace '/usr/include/libevdev-1.0' '${libevdev}/include/libevdev-1.0'

    substituteInPlace packaging/linux/sunshine.desktop \
      --replace '@PROJECT_NAME@' 'Sunshine' \
      --replace '@PROJECT_DESCRIPTION@' 'Self-hosted game stream host for Moonlight'
  '';

  preBuild = ''
    # copy node_modules where they can be picked up by build
    mkdir -p ../node_modules
    cp -r ${ui}/node_modules/* ../node_modules
  '';

  # allow Sunshine to find libvulkan
  postFixup = lib.optionalString cudaSupport ''
    wrapProgram $out/bin/sunshine \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath [ vulkan-loader ]}
  '';

  postInstall = ''
    install -Dm644 ../packaging/linux/${pname}.desktop $out/share/applications/${pname}.desktop
  '';

  passthru.updateScript = ./updater.sh;

  meta = with lib; {
    description = "Sunshine is a Game stream host for Moonlight";
    homepage = "https://github.com/LizardByte/Sunshine";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ devusb ];
    platforms = platforms.linux;
  };
}
