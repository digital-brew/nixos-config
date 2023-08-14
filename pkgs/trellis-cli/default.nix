{ lib, stdenv, buildGoModule, fetchurl }:

buildGoModule rec {
  pname = "trellis";
  version = "v1.11.1";

#  src = fetchFromGitHub {
#    owner = "root";
#    repo = "trellis-cli";
#    rev = "${version}";
#    hash = "sha256-V+OaJ007cp/77Lqwk532E5Iye8yjFURrctwljg2j6Ks=";
#  };

  src = fetchurl {
    url = "https://github.com/roots/trellis-cli/releases/download/${version}/trellis_Linux_x86_64.tar.gz";
    hash = "sha256-V+OaJ007cp/77Lqwk532E5Iye8yjFURrctwljg2j6Ks=";
  };

  sourceRoot = "trellis";
  vendorHash =  "sha256-hzXqT5pQ0Q/IELSoMwrhmrY1pw0jOUukShnNowsQt6o=";
  proxyVendor = false;
  doCheck = false;

  meta = with lib; {
    description = "A CLI to manage Trellis projects";
    homepage = "https://roots.io/trellis/";
    license = licenses.mit;
    maintainers = [];
  };
}
