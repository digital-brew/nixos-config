{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.office = {
    enable = mkEnableOption "office service";
  };

  config = mkIf config.modules.office.enable {
    environment.systemPackages = with pkgs; [
     
    ];

    programs = {
     
    };
  };
}