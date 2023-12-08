{ config, lib, pkgs, modulesPath, ... }:

{

  nixpkgs.overlays = [
#    (self: super: {
#      discord = pkgs.discord.overrideAttrs(
#        _: { src = builtins.fetchTarball {
#          url = "https://install.devenv.sh/latest";
#          sha256 = "sha256:0wj5455mk0kgm4vnvqia6x4qhkwwf3cn07pdsd4wmfdbp9rxr44a";
#        }; }
#      );
#      })
#    (self: super: {
#      discord = pkgs.discord.overrideAttrs (old: {
#        src = builtins.fetchTarball {
#          url = "https://install.devenv.sh/latest";
#          sha256 = "sha256:0wj5455mk0kgm4vnvqia6x4qhkwwf3cn07pdsd4wmfdbp9rxr44a";
#        };
#      });
#    })
    (self: super: {
      phpstorm = pkgs.jetbrains.phpstorm.overrideAttrs (old: {
        src = builtins.fetchTarball {
          url = "https://download.jetbrains.com/webide/PhpStorm-2023.2.4.tar.gz";
          sha256 = "sha256:1141yj5a4xvvz48lzcrw4k1p5iq25ksmlg0vjmklbp1hcac6bqw4";
        };
      });
    })
#    (self: super: {
#      phpstorm = pkgs.xdg-desktop-portal-hyprland.overrideAttrs (old: {
#        src = builtins.fetchTarball {
#          url = "https://github.com/hyprwm/xdg-desktop-portal-hyprland/archive/refs/tags/v1.2.3.tar.gz";
#          sha256 = "sha256:0108y8bi5njkdw8xai611vvda9i6vh6dzp0lghj7x5g8md0755zb";
#        };
#      });
#    })
#    (self: super: {
#      ngrok = super.ngrok.overrideAttrs(
#        _: { src = builtins.fetchTarball {
#          url = "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz";
#          sha256 = "0m0dd71y29g30j7y5j0qwbf934kjkvcf89sx9g88lx6lgam2qlj4";
#        }; }
#      );
#      })
    (self: super: {
#      zoomUsFixed = pkgs.zoom-us.overrideAttrs (old: {
#        postFixup = old.postFixup + ''
#          wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
#        '';});
      zoomUsFixed = pkgs.zoom-us.overrideAttrs (old: {
        postFixup = old.postFixup + ''
          wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
        '';});
        })
#    (self: super: {
#      betterbird = super.betterbird.overrideAttrs(
#        _: { src = builtins.fetchTarball {
#          url = "https://www.betterbird.eu/downloads/LinuxArchive/betterbird-115.3.2-bb15.en-US.linux-x86_64.tar.bz2";
#          sha256 = "1ykhjvl8qhs9bpz85av0n3s8zdvxwksl3y42vs8p2a5zsfvzn90h";
#        }; }
#      );
#    })
#    (self: super: {
#      rsync = pkgs.rsync.overrideAttrs (old: {
#        src = builtins.fetchTarball {
#          url = "https://github.com/WayneD/rsync/archive/refs/tags/v3.3.0pre1.tar.gz";
#          sha256 = "0rdv8hl8150add4s5wq0z644nx0j0qyvvpdsx9ab82ky6drnx93k";
#        };
#      });
#    })
  ];
}