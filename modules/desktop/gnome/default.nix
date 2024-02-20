# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: GNOME
# Type: Module (NixOS)
# Location: /modules/desktop/gnome/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.desktop.gnome = {
    enable = lib.mkEnableOption "Whether to enable GNOME desktop manager.";
  };

  config = lib.mkIf config.customModules.desktop.gnome.enable {
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
    ];
  };
}
