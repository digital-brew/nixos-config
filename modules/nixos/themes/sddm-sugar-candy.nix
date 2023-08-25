{ stdenv, fetchFromGitHub }:
{
  default = stdenv.mkDerivation rec {
    pname = "sddm-sugar-candy";
    version = "1.6";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-candy
    '';
    src = fetchFromGitHub {
      owner = "Kangie";
      repo = "sddm-sugar-candy";
      rev = "v${version}";
      sha256 = "sha256-p2d7I0UBP63baW/q9MexYJQcqSmZ0L5rkwK3n66gmqM=";
    };
  };
}