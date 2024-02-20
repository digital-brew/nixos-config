# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: TRELLIS-CLI
# Type: Package (NixOS)
# Location: /packages/trellis-cli/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ fetchurl, stdenv }:

stdenv.mkDerivation rec {
  name = "trellis";
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
}
