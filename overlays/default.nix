# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: OVERLAYS
# Type: Overlays (NixOS)
# Location: /overlays/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ pkgs, config, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      phpstorm = pkgs.jetbrains.phpstorm.overrideAttrs (old: {
        src = builtins.fetchTarball {
          url = "https://download.jetbrains.com/webide/PhpStorm-2023.3.2.tar.gz";
          sha256 = "sha256:0hzwd9abydk6rc4wd3ipkpnl797ch35vir7lk0dxr9n5da90jaif";
        };
      });
    })
  ];
}
