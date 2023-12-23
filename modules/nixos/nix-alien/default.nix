{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.nixAlien = {
    enable = mkEnableOption "nix-alien service";
  };

  config = mkIf config.modules.nixAlien.enable {
    environment.systemPackages = with pkgs; [
     
    ];

    programs = {
     
    };
  };
}