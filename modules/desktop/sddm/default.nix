# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: SDDM
# Type: Module (NixOS)
# Location: /modules/desktop/sddm/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.desktop.sddm = {
    enable = lib.mkEnableOption "Whether to enable sddm as the display manager.";
  };

  config = lib.mkIf config.customModules.desktop.sddm.enable {
    services.xserver.displayManager.sddm = {
      enable = true;
      theme = "sugar-candy";
      settings = {
        General = {
          ScreenWidth = "1920";
          ScreenHeight = "1080";
          FormPosition = "center";
          CursorTheme = "Breeze_Snow";
          CursorSize = 16;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };
}
