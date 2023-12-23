{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.nix-alien = {
    enable = mkEnableOption "nix-alien service";
  };

  config = mkIf config.modules.nix-alien.enable {
   
  };
}