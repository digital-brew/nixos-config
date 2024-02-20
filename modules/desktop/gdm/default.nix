# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: GDM
# Type: Module (NixOS)
# Location: /modules/desktop/gdm/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.desktop.gdm = {
    enable = lib.mkEnableOption "Whether to enable GDM, the GNOME Display Manager.";
  };

  config = lib.mkIf config.customModules.desktop.gdm.enable {
    services.xserver.displayManager.gdm.enable = true;
  };
}
