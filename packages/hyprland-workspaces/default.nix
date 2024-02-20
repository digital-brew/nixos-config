# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: HYPRLAND-WORKSPACES
# Type: Imports (NixOS)
# Location: /packages/hyprland-workspaces/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
{
  options.myPackages.hyprlandWorkspaces = {
    enable = lib.mkEnableOption "hyprland workspaces plugin";
  };

  config = lib.mkIf config.myPackages.hyprlandWorkspaces.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package.nix {};
    in
      [ package ];
  };
}
