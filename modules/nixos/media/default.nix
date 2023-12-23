{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.media = {
    enable = mkEnableOption "media service";
  };

  config = mkIf config.modules.media.enable {
    environment.systemPackages = with pkgs; [
     
    ];

    programs = {
     
    };
  };
}