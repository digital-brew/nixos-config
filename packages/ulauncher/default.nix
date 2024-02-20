# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: STRIPE-CLI
# Type: Imports (NixOS)
# Location: /packages/stripe-cli/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
{
  options.myPackages.ulauncher = {
    enable = lib.mkEnableOption "ulauncher package";
  };

  config = lib.mkIf config.myPackages.ulauncher.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package.nix {};
    in
      [ package ];
  };
}
