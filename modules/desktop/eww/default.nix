# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: EWW
# Type: Module (HomeManager)
# Location: /modules/desktop/waybar/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, system, inputs, extraConfig, ... }:
let
  wayland = inputs.nixpkgs-wayland.packages.${system};
  username = extraConfig.mainUser.username;
in
{
  options.customModules.desktop.eww = {
    enable = lib.mkEnableOption "Whether to enable the eww, Elkowars Wacky Widgets, a standalone widget system.";
  };

  config = lib.mkIf config.customModules.desktop.eww.enable {
    home-manager.users.${username} = {
      home.packages = [
        wayland.eww-wayland
      ];
    };
  };
}