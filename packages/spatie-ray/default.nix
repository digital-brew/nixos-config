# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: SPATIE-RAY
# Type: Imports (NixOS)
# Location: /packages/spatie-ray/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
{
  options.myPackages.spatieRay = {
    enable = lib.mkEnableOption "spatie ray package";
  };

  config = lib.mkIf config.myPackages.spatieRay.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package.nix {};
    in
      [ package.default ];
  };
}
