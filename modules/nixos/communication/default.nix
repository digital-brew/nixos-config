{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.communication = {
    enable = mkEnableOption "communication service";
  };

  config = mkIf config.modules.communication.enable {
    environment.systemPackages = with pkgs; [
     
    ];

    programs = {
     
    };
  };
}