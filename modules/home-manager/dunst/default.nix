{ lib, config, pkgs, ... }:
  with lib;
{
  options.dunst = {
    enable = mkEnableOption "dunst service";
  };

  config = mkIf config.dunst.enable {
    
  };
}