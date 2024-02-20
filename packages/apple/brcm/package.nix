# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: APPLE T2 FANS
# Type: Package (NixOS)
# Location: /packages/apple/fans/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, stdenv, pkgs, fetchFromGitHub }:

{
  default = stdenv.mkDerivation rec {
    name = "brcm-firmware";
    nativeBuildInputs = [pkgs.python3];
    stripRoot = false;
    wifi = pkgs.fetchzip {
      url = "https://mirror.funami.tech/arch-mact2/firmware/wifi.tar.gz";
      sha256 = "sha256-EU+VO0eBDXrf1TzHFnLM7sizDQG0eH05AN3NNpJ5XmA=";
    };
    bluetooth = pkgs.fetchzip {
      url = "https://mirror.funami.tech/arch-mact2/firmware/bluetooth.tar.gz";
      sha256 = "sha256-7WHELxuULBv+jYSH/d5InZOkxVmclkMFWM5bFOhf6Z8=";
    };
    script = pkgs.fetchurl {
      url = "https://wiki.t2linux.org/tools/firmware.sh";
      sha256 = "sha256-IeuASy0+iNfx7FEt0RvRDNpNCmFbIMia0KGiCQVkiDw=";
    };
    buildCommand = ''
      dir="$out/lib/firmware"
      mkdir -p "$dir"
      cp -r ${wifi} wifi
      cp -r ${bluetooth} bluetooth
      python3 ${script} .
      tar xf firmware.tar
      cp -r brcm $dir
    '';
  };
}