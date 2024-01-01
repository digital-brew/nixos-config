{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.desktop.gnome = {
    enable = mkEnableOption "gnome service";
  };

  config = mkIf config.modules.desktop.gnome.enable {
    services.xserver.desktopManager.gnome.enable = true;
  };
}
