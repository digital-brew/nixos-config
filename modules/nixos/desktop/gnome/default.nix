{ lib, config, pkgs, ... }:
  with lib;
{
  options.gnome = {
    enable = mkEnableOption "display-manager service";
  };

  config = mkIf config.gnome.enable {
   
  };
}