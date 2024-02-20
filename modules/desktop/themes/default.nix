# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: THEMES
# Type: Module (NixOS)
# Location: /modules/desktop/themes/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.desktop.themes = {
    enable = lib.mkEnableOption "Whether to enable all themes for desktop.";
  };

  config = lib.mkIf config.customModules.desktop.themes.enable {

  };
}
