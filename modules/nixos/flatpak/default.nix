{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.flatpak = {
    enable = mkEnableOption "flatpak service";
  };

  config = mkIf config.modules.flatpak.enable {
   
  };
}