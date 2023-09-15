{ stdenv, fetchFromGitHub }:
{
  default = stdenv.mkDerivation rec {
    name = "macbook-pro-t2-fans";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/bin
      cp t2fand $out/bin
      cp t2fand.service /usr/lib/systemd/system
      chmod 644 /usr/lib/systemd/system/t2fand.service
      chmod 700 $out/bin/t2fand
    '';
    src = fetchFromGitHub {
      owner = "NoaHimesaka1873";
      repo = "t2fand";
      rev = "v1.2.0";
      hash = "0000000000000000000000000000000000000000000000000000";
    };
  };
}