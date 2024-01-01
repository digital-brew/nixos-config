{ lib, config, pkgs, ... }:
  with lib;
{
  options.icons = {
    enable = mkEnableOption "icons service";
  };

  config = mkIf config.icons.enable {
    
  };
}