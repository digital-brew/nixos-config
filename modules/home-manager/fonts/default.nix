{ lib, config, pkgs, ... }:
  with lib;
{
  options.fonts = {
    enable = mkEnableOption "fonts service";
  };

  config = mkIf config.fonts.enable {
    
  };
}