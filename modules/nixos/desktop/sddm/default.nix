{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.desktop.sddm = {
    enable = mkEnableOption "sddm service";
  };

  config = mkIf config.modules.desktop.sddm.enable {
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
  };
}
