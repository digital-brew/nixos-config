{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.samba = {
    enable = mkEnableOption "samba service";
  };

  config = mkIf config.modules.samba.enable {
   
  };
}