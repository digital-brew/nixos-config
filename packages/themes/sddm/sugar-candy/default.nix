# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: THEME: SUGAR-CANDY
# Type: Imports (NixOS)
# Location: /packages/themes/sddm/sugar-candy/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
{
  options.myPackages.themes.sddm.sugarCandy = {
    enable = lib.mkEnableOption "sddm sugar-candy theme package";
  };

  config = lib.mkIf config.myPackages.themes.sddm.sugarCandy.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package.nix {};
    in
      [ package ];
  };
}
