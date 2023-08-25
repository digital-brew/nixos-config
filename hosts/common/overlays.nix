{ pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs(
        _: { src = builtins.fetchTarball {
          url = "https://install.devenv.sh/latest";
          sha256 = "0pml1x6pzmdp6h19257by1x5b25smi2y60l1z40mi58aimdp59ss";
        }; }
      );

      ngrok = super.ngrok.overrideAttrs(
        _: { src = builtins.fetchTarball {
          url = "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz";
          sha256 = "0m0dd71y29g30j7y5j0qwbf934kjkvcf89sx9g88lx6lgam2qlj4";
        }; }
      );

      betterbird = super.betterbird.overrideAttrs(
        _: { src = builtins.fetchTarball {
          url = "https://www.betterbird.eu/downloads/115-Preview/betterbird-115.1.0-bb8.en-US.linux-x86_64.tar.bz2";
          sha256 = "0xppbjpq2n3c97rznixrvn57z05d7ama8w99fw3awwcfjrfdk9vw";
        }; }
      );

#      devenv = super.devenv.overrideAttrs(
#        _: { src = builtins.fetchTarball {
#          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
#          sha256 = "0wj5455mk0kgm4vnvqia6x4qhkwwf3cn07pdsd4wmfdbp9rxr44a";
#        }; }
#      );
    })
  ];
}