# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: XFCE
# Type: Module (NixOS)
# Location: /modules/desktop/xfce/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.desktop.xfce = {
    enable = lib.mkEnableOption "Whether to enable the Xfce desktop environment.";
  };

  config = lib.mkIf config.customModules.desktop.xfce.enable {
    services.xserver.desktopManager.xfce = {
      enable = true;
    };

    programs.xfconf.enable = true;
  };
}
