# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: TRELLIS-CLI
# Type: Imports (NixOS)
# Location: /packages/trellis-cli/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.myPackages.trellisCli = {
    enable = lib.mkEnableOption "trellis-cli package";
  };

  config = lib.mkIf config.myPackages.trellisCli.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package.nix {};
    in
      [ package ];
  };
}
