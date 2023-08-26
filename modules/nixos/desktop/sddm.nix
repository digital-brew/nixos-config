{ config, lib, pkgs, ... }:

{
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
}