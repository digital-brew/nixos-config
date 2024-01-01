{ lib, config, pkgs, ... }:
  with lib;
{
  options.ssh = {
    enable = mkEnableOption "ssh service";
  };

  config = mkIf config.ssh.enable {
    
  };
}