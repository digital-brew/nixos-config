# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: HYPRLAND
# Type: Imports (NixOS)
# Location: /modules/desktop/hyprland/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, inputs, ... }:
let
  hyprland = inputs.hyprland.nixosModules.default;
in
{
  imports = [
    hyprland
    ./hyprland.nix
  ];
}
