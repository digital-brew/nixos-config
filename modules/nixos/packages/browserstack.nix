{ stdenv, fetchurl, unzip }:
{
  default = stdenv.mkDerivation rec {
    name = "browserstack";
    nativeBuildInputs = [ unzip ];
    buildInputs = [ unzip ];
    # Work around the "unpacker appears to have produced no directories"
    # case that happens when the archive doesn't have a subdirectory.
    sourceRoot = ".";
    installPhase = ''
      mkdir -p $out/bin
      cp BrowserStackLocal $out/bin
    '';
    src = fetchurl {
      url = "https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip";
      hash = "sha256-oZBRouiZ69Ar2/8g16mawAaa5DqOhYeFtbjX46ci7RY=";
    };
  };
}