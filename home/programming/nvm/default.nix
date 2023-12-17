{ config, pkgs, inputs, lib, ... }:

let
  name = "nvm";
  version = "0.39.7";

  src = pkgs.fetchFromGitHub {
    owner = "nvm-sh";
    repo = name;
    rev = "v${version}";
    hash = "sha256-wtLDyLTF3eOae2htEjfFtx/54Vudsvdq65Zp/IsYTX8=";
  };

  nvm = pkgs.runCommand "nvm-sh" { } ''
    mkdir -p $out
    cp ${src}/nvm.sh $out
  '';

  nvm_find_nvmrc_fn = pkgs.writeText "nvm_find_nvmrc.fish" ''
    function nvm_find_nvmrc
      bass source ${nvm}/nvm.sh --no-use ';' nvm_find_nvmrc
    end
  '';

  nvm_fn = pkgs.writeText "nvm.fish" ''
    function nvm
      bass source ${nvm}/nvm.sh --no-use ';' nvm $argv
    end
  '';

  nvm_init = pkgs.writeText "nvm_init.fish" ''
    bass export NVM_DIR=$HOME/.nvm

    set -l default_node_version (nvm version default)
    set -l node_version (nvm version)
    set -l nvmrc_path (nvm_find_nvmrc)
    if test -n "$nvmrc_path"
      set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
      if test "$nvmrc_node_version" = "N/A"
        nvm install (cat $nvmrc_path)
      else if test "$nvmrc_node_version" != "$node_version"
        nvm use $nvmrc_node_version
      end
    else if test "$node_version" != "$default_node_version"
      echo "Reverting to default Node version"
      nvm use default
    end
  '';

  nvm_fish_src = pkgs.runCommand "nvm-fish" { } ''
    mkdir -p $out/functions
    mkdir -p $out/conf.d

    cp ${nvm_find_nvmrc_fn} $out/functions/nvm_find_nvmrc.fish
    cp ${nvm_fn} $out/functions/nvm.fish
    cp ${nvm_init} $out/conf.d/init.fish
  '';

  nvm_fish = pkgs.fishPlugins.buildFishPlugin {
    pname = name;
    inherit version;

    src = nvm_fish_src;

    meta = with lib; {
      description =
        "Node Version Manager - POSIX-compliant bash script to manage multiple active node.js versions";
      license = licenses.mit;
      maintainers = with maintainers; [ ];
      platforms = with platforms; unix;
    };
  };
in {
  home.packages = with pkgs; [ nvm_fish ];

  home.sessionVariables = { LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib"; };

  home.activation = {
    initializeNvm = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # If the ~/.nvm directory exists, then we assume that nvm has already been
      # installed and activated. Otherwise, we activate it.

      if [ -d $HOME/.nvm ];
      then
        echo "nvm already initialized"
      else
        echo "Initializing nvm"
        $DRY_RUN_CMD mkdir -p $HOME/.nvm

        # Add required packages to the PATH for nvm to work
        $DRY_RUN_CMD export PATH=$PATH:${pkgs.curl}/bin:${pkgs.gawk}/bin:${pkgs.gnutar}/bin:${pkgs.gzip}/bin

        $DRY_RUN_CMD source $HOME/.nvm/nvm.sh
        $DRY_RUN_CMD nvm install 20
      fi
    '';
  };
}
