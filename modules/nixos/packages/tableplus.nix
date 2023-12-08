{ stdenv, fetchurl, pkgs }:
{
  default = stdenv.mkDerivation rec {
  name = "TablePlus";

    libldapSrc = fetchurl {
      url = "http://ftp.de.debian.org/debian/pool/main/o/openldap/libldap-2.5-0_2.5.13+dfsg-5_amd64.deb";
      sha256 = "sha256-S2ww9lVBScWUYo2UXtxgA/DuqNDME0FjjA5xN12xR+0=";
    };

    libsaslSrc = fetchurl {
      url = "http://archive.ubuntu.com/ubuntu/pool/main/c/cyrus-sasl2/libsasl2-2_2.1.28+dfsg1-3_amd64.deb";
      sha256 = "sha256-b33+6PkcJfxuvh4TDjpMEK/OXR9XQXAmIxCjJYSsWiY=";
    };

    tableplusSrc = fetchurl {
      url = "https://deb.tableplus.com/debian/21/pool/main/t/tableplus/tableplus_0.1.228_amd64.deb";
      sha256 = "sha256-I+wXKfDeONiNvrfmY4b8PVlKC80cKjjMGzfuKD+S+tg=";
    };

    unpackPhase = ''
      runHook preUnpack
      dpkg-deb -x $tableplusSrc tableplus
      dpkg-deb -x $libldapSrc libldap
      dpkg-deb -x $libsaslSrc libsasl
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/lib"
      mkdir -p "$out/bin"
      mkdir -p "$out/resource"
      # deps
      cp -R libldap/usr/lib/x86_64-linux-gnu/* "$out/lib/"
      cp -R libsasl/usr/lib/x86_64-linux-gnu/* "$out/lib/"
      # tableplus
      cp -R "tableplus/opt/tableplus/tableplus" "$out/bin/tableplus"
      cp -R "tableplus/opt/tableplus/resource/" "$out/resource"
      # chmod -R g-w "$out"
      # # Desktop file
      # mkdir -p "$out/share/applications"
      #cp "$desktopItem}/share/applications/"* "$out/share/applications"
      runHook postInstall
    '';

    nativeBuildInputs = with pkgs; [
      autoPatchelfHook
      dpkg
      makeWrapper
      wrapGAppsHook
    ];

    buildInputs = with pkgs; [
      gtksourceview
      gtksourceview4
      json-glib
      libgee
      libkrb5
      libsecret
      openldap
      stdenv.cc.cc.lib
    ];

    meta = with stdenv.lib; {
      description = "Tableplus";
      homepage = https://tableplus.com/;
      platforms = [ "x86_64-linux" ];
    };
  };
}