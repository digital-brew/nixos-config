{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.apple.sound = {
    enable = mkEnableOption "apple sound service";
  };

  config = mkIf config.modules.apple.sound.enable {
   
  };
}