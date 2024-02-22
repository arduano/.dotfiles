{ stdenv, lib, fetchurl, fetchpatch, p7zip, python3, arduano, ... }:

stdenv.mkDerivation rec {
  pname = "p7zip-gui";
  version = "16.02";

  src = fetchurl {
    url = "https://downloads.sourceforge.net/project/p7zip/p7zip/${version}/p7zip_${version}_src_all.tar.bz2";
    sha256 = "5eb20ac0e2944f6cb9c2d51dd6c4518941c185347d4089ea89087ffdd6e2341f";
  };

  buildInputs = [ p7zip python3 arduano.wxwidgets_gtk3 ];

  patches = [
    (fetchpatch {
      url = "https://src.fedoraproject.org/rpms/p7zip/raw/rawhide/f/14-Fix-g++-warning.patch";
      sha256 = "sha256-LF4KI+tpNz1ymwmC2vWRsZ83IfWk4NFNPcdHek9Lexc=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/archlinux/svntogit-packages/a82b67f5d36f374afd154e7648bb13ec38a3c497/trunk/CVE-2016-9296.patch";
      sha256 = "sha256-FcgWPwADRv3CTRGZbPWxeEwmSQVf01s/qnwZEtWfiyc=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/archlinux/svntogit-packages/a82b67f5d36f374afd154e7648bb13ec38a3c497/trunk/CVE-2017-17969.patch";
      sha256 = "sha256-xonNoJXv1Ycghb+i0xM0oVLzUU1tAw8adz2UBrY7yDw=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/archlinux/svntogit-packages/a82b67f5d36f374afd154e7648bb13ec38a3c497/trunk/CVE-2018-5996.patch";
      sha256 = "sha256-0UaUlJt0BftFha5rJWIicNz5Pm5dQtGK5B2e1XKgl/o=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/archlinux/svntogit-packages/a82b67f5d36f374afd154e7648bb13ec38a3c497/trunk/CVE-2018-10115.patch";
      sha256 = "sha256-OgSTCQQKUZXa5k0gHbDZgTH9SqxMuwWukSzeUKkuX+s=";
    })
    (fetchpatch {
      url = "https://src.fedoraproject.org/rpms/p7zip/raw/rawhide/f/gcc10-conversion.patch";
      sha256 = "sha256-GTDromT6mlnDYesKLWb5/tDmzTnd4aTK6WajgscKHqI=";
    })
  ];

  postPatchPhase = ''
    # Architecture-specific operations
    if [[ "${stdenv.hostPlatform.system}" == *"-x86_64-linux" ]]; then
      cp makefile.linux_amd64_asm makefile.machine
    elif [[ "${stdenv.hostPlatform.system}" == *"-i686-linux" ]]; then
      cp makefile.linux_x86_asm_gcc_4.X makefile.machine
    fi

    # Replace x86_64-linux-gnu in .depend files
    sed -i 's/x86_64-linux-gnu//g' CPP/7zip/*/*/*.depend

    # Remove specific desktop file (related to FS#43766)
    rm -f GUI/kde4/p7zip_compress.desktop

    # Modify and run the generate.py script in the Utils directory
    pushd Utils
    sed -i 's/_do_not_use//g' generate.py
    patchShebangs generate.py

    ./generate.py

    popd
  '';

  buildPhase = ''
    ls
    make 7zFM 7zG OPTFLAGS="''${CXXFLAGS}"
  '';

  installPhase = ''
    # Install to the package directory
    make install DEST_DIR="$out" DEST_HOME="/" DEST_MAN="/share/man"

    # Remove files that are provided by the p7zip package
    rm -rf $out/lib/p7zip/{7z.so,Codecs}
    rm -rf $out/share/{doc,man}

    # Convert `/usr/lib/p7zip/7zG` to its respective nix path in $out/bin/7zG
    sed -i "s|/lib/p7zip/7zG|$out/lib/p7zip/7zG|g" $out/bin/7zG

    # Install icons and desktop files
    mkdir -p $out/share/icons/hicolor/32x32/apps
    cp GUI/p7zip_32.png $out/share/icons/hicolor/32x32/apps/p7zip.png
    mkdir -p $out/share/{applications,kde4/services/ServiceMenus}
    cp GUI/kde4/*.desktop $out/share/kde4/services/ServiceMenus
    mkdir -p $out/share/kservices5/ServiceMenus
    cp GUI/kde4/*.desktop $out/share/kservices5/ServiceMenus
    cp ${./7zFM.desktop} $out/share/applications
    chmod +x $out/bin/p7zipForFilemanager
  '';

  meta = with lib; {
    description = "Graphic user interface (alpha quality) for the 7zip file archiver";
    homepage = "http://p7zip.sourceforge.net";
    license = licenses.lgpl3; # You need to adjust the license accordingly
    platforms = platforms.linux;
  };
}
