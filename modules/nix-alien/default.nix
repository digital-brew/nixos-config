# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: NIX-ALIEN
# Type: Module (NixOS)
# Location: /modules/nix-alien/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.nixAlien = {
    enable = lib.mkEnableOption "Whether to enable nix-alien, service to run unpatched binaries.";
  };

  config = lib.mkIf config.customModules.nixAlien.enable {
    environment.systemPackages = with pkgs; [

    ];

    programs = {

    };
  };
}
