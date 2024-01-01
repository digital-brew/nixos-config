{ lib, config, pkgs, ... }:
  with lib;
{
  options.waybar = {
    enable = mkEnableOption "waybar service";
  };

  config = mkIf config.waybar.enable {
    
  };
}