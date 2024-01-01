{ lib, config, pkgs, ... }:
  with lib;
{
  options.git = {
    enable = mkEnableOption "git service";
  };

  config = mkIf config.git.enable {
    
  };
}