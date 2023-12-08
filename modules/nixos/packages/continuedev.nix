{ stdenv, fetchFromGitHub, unzip, python311, python311Packages }:
{
  default = stdenv.mkDerivation rec {
    name = "continuedev";
    dontBuild = true;
    nativeBuildInputs = [ unzip python311 python311Packages.pip python311Packages.fastapi ];
    buildInputs = [ unzip ];
    # Work around the "unpacker appears to have produced no directories"
    # case that happens when the archive doesn't have a subdirectory.
#    sourceRoot = ".";
    installPhase = ''
      mkdir -p $out/bin
      sh build.sh
      cp dist $out/bin
    '';
    src = fetchFromGitHub {
      owner = "continuedev";
      repo = "continue";
      rev = "71ab8a99dfe88e80956139ce90a849815a0b5bdd";
      hash = "sha256-4WquMwJOJXK8OPPLeeBU7vHHb35lbDGhCzIUaxI0n60=";
    };
  };
}