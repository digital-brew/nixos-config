# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: APPLE T2 FANS
# Type: Imports (NixOS)
# Location: /packages/apple/fans/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
{
  options.myPackages.appleWifiBluetooth = {
    enable = lib.mkEnableOption "macbook pro t2 chip fans speed regulation";
  };

  config = lib.mkIf config.myPackages.appleWifiBluetooth.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package.nix {};
    in
      [ package.default ];
  };
}
