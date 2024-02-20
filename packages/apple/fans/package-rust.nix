{ fetchFromGitHub, stdenv, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "t2fanrd";
  version = "master";

  src = fetchFromGitHub {
    owner = "GnomedDev";
    repo = "T2FanRD";
    rev = "${version}";
    hash = "sha256-HVHPeY3/ka3CFQ/5Q32sl1yqhUzPChWkBI+S1CurA7Q=";
  };

  cargoHash = "sha256-e0ddzL0igEyDm1CxPzmKcwUcRBKrsudAKl1BLFpGJQs=";

  buildPhase = ''
    cargo build --release
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp target/release/t2fanrd $out/bin
  '';

  meta = with lib; {
    description = "Simple Fan Daemon for T2 Macs";
    mainProgram = "t2fanrd";
    platforms = platforms.linux;
  };
}
