{ lib, config, pkgs, ... }:
  with lib;
{
  options.eww = {
    enable = mkEnableOption "eww service";
  };

  config = mkIf config.eww.enable {
    
  };
}