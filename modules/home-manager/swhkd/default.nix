{ lib, config, pkgs, ... }:
  with lib;
{
  options.swhkd = {
    enable = mkEnableOption "swhkd service";
  };

  config = mkIf config.swhkd.enable {
    
  };
}