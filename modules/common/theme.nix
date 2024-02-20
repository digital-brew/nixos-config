# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: THEME (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
in
{
  environment.systemPackages = with pkgs; [
    nwg-look                                  # Nwg-look is a GTK3 settings editor, designed to work properly in wlroots-based Wayland environment.
    maia-icon-theme
    pantheon.elementary-icon-theme
    rose-pine-gtk-theme
    rose-pine-icon-theme
    arc-theme
    arc-icon-theme
    arc-kde-theme
    ayu-theme-gtk
  ];

  # Needed for anything GTK related
  programs.dconf.enable = true;

  qt.enable = true;
  qt.style = "breeze";


  home-manager.users.${username} = {
    gtk.enable = true;

    home.pointerCursor = {                                       # This will set cursor system-wide so applications can not choose their own
      gtk.enable = true;
      name = "Breeze_Snow";
      package = pkgs.libsForQt5.breeze-gtk;
      size = 16;
    };
    gtk.theme = {
      name = "Arc-Dark";

    };
    gtk.iconTheme = {
      name = "rose-pine-dawn";

    };
  };
}
