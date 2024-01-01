{ lib, config, pkgs, ... }:
  with lib;
{
  options.file-manager = {
    enable = mkEnableOption "file-manager service";
  };

  config = mkIf config.file-manager.enable {
    
  };
}