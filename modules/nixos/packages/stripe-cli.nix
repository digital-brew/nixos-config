{ stdenv, fetchurl }:
{
  default = stdenv.mkDerivation rec {
    name = "stripe";
#    dontBuild = true;
#    phases = [ "installPhase" ]; # Removes all phases except installPhase
#    dontUnpack = true;
  # Work around the "unpacker appears to have produced no directories"
    # case that happens when the archive doesn't have a subdirectory.
    sourceRoot = ".";
    installPhase = ''
      mkdir -p $out/bin
      cp stripe $out/bin
    '';
    src = fetchurl {
      url = "https://github.com/stripe/stripe-cli/releases/download/v1.17.2/stripe_1.17.2_linux_x86_64.tar.gz";
      sha256 = "sha256-awIyrhVP7AmZ5QwpSZ/ZZRbpJHK6Xf3MheoDfOJLYT8=";
    };
  };
}