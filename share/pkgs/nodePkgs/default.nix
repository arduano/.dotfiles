{ buildNpmPackage
, lib
, nodejs_24
}:

buildNpmPackage {
  pname = "arduano-node-packages";
  version = "0.1.0";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./package.json
      ./package-lock.json
    ];
  };

  nodejs = nodejs_24;
  npmDepsHash = "sha256-1ycX35LxvW4aucDj5CvocvnduS3YPs06w/8a5Ekf4NM=";

  dontNpmBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/node_modules/arduano-node-packages $out/bin
    cp -R node_modules package.json package-lock.json $out/lib/node_modules/arduano-node-packages/

    for bin in marp gt graphite workmaps; do
      ln -s $out/lib/node_modules/arduano-node-packages/node_modules/.bin/$bin $out/bin/$bin
    done

    runHook postInstall
  '';
}
