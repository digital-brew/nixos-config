{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.desktop.themes = {
    enable = mkEnableOption "themes service";
  };

  config = mkIf config.modules.desktop.themes.enable {
   
  };
}