{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.desktop.xserver = {
    enable = mkEnableOption "xserver service";
  };

  config = mkIf config.modules.desktop.xserver.enable {
    services.xserver.enable = true;
  };
}
