{ lib, config, pkgs, ... }:
  with lib;
{
  options.terminal = {
    enable = mkEnableOption "terminal service";
  };

  config = mkIf config.terminal.enable {
    
  };
}