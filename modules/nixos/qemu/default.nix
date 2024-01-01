{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.qemu = {
    enable = mkEnableOption "qemu service";
  };

  config = mkIf config.modules.qemu.enable {
   
  };
}