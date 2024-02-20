# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: APPLE T2 FANS
# Type: Imports (NixOS)
# Location: /packages/apple/fans/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
{
  options.myPackages.applet2fand = {
    enable = lib.mkEnableOption "macbook pro t2 chip fans speed regulation";
  };

  config = lib.mkIf config.myPackages.applet2fand.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package-rust.nix {};
    in
      [ package ];
  };
}
