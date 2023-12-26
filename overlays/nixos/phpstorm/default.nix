{ config, lib, pkgs, modulesPath, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      phpstorm = pkgs.jetbrains.phpstorm.overrideAttrs (old: {
        src = builtins.fetchTarball {
          url = "https://download.jetbrains.com/webide/PhpStorm-2023.2.4.tar.gz";
          sha256 = "sha256:1141yj5a4xvvz48lzcrw4k1p5iq25ksmlg0vjmklbp1hcac6bqw4";
        };
      });
    })
  ];
}