{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.office = {
    enable = mkEnableOption "office service";
  };

  config = mkIf config.modules.office.enable {
    environment.systemPackages = with pkgs; [
      libreoffice                               # Comprehensive, professional-quality productivity suite
      pro-office-calculator                     # A completely normal office calculator
    ];

    programs = {
     
    };
  };
}