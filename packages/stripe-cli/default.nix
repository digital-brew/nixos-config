# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: STRIPE-CLI
# Type: Imports (NixOS)
# Location: /packages/stripe-cli/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
{
  options.myPackages.stripeCli = {
    enable = lib.mkEnableOption "stripe-cli package";
  };

  config = lib.mkIf config.myPackages.stripeCli.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package.nix {};
    in
      [ package ];
  };
}
