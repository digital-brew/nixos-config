# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: THORIUM-BROWSER
# Type: Imports (NixOS)
# Location: /packages/thorium-browser/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
{
  options.myPackages.thoriumBrowser = {
    enable = lib.mkEnableOption "thorium browser package";
  };

  config = lib.mkIf config.myPackages.thoriumBrowser.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package.nix {};
    in
      [ package.default ];
  };
}
