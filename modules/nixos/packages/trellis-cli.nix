{ stdenv, fetchurl }:
{
  default = stdenv.mkDerivation rec {
    name = "trellis";
#    dontBuild = true;
#    phases = [ "installPhase" ]; # Removes all phases except installPhase
#    dontUnpack = true;
  # Work around the "unpacker appears to have produced no directories"
    # case that happens when the archive doesn't have a subdirectory.
    sourceRoot = ".";
    installPhase = ''
      mkdir -p $out/bin
      cp trellis $out/bin
    '';
    src = fetchurl {
      url = "https://github.com/roots/trellis-cli/releases/latest/download/trellis_Linux_x86_64.tar.gz";
      hash = "sha256-V+OaJ007cp/77Lqwk532E5Iye8yjFURrctwljg2j6Ks=";
    };
  };
}