{ lib
, stdenvNoCC
, fetchurl
, makeWrapper
, xdg-utils
}:

stdenvNoCC.mkDerivation rec {
  pname = "gogcli";
  version = "0.11.0";

  src = fetchurl {
    url = "https://github.com/steipete/gogcli/releases/download/v${version}/gogcli_${version}_linux_amd64.tar.gz";
    hash = "sha256-ypi6VuKczTcT/nv4Nf3KAK4bl83LewvF45Pn7bQInIQ=";
  };

  nativeBuildInputs = [ makeWrapper ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -Dm755 gog $out/bin/gog
    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/gog \
      --prefix PATH : ${lib.makeBinPath [ xdg-utils ]}
  '';

  meta = with lib; {
    description = "Google Suite CLI for Gmail/Calendar/Drive and more";
    homepage = "https://gogcli.sh/";
    license = licenses.mit;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    mainProgram = "gog";
  };
}
