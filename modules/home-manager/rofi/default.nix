{ lib, config, pkgs, ... }:
  with lib;
{
  options.rofi = {
    enable = mkEnableOption "rofi service";
  };

  config = mkIf config.rofi.enable {
    
  };
}