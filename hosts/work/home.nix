{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/services/dunst.nix
    ../../modules/home-manager/services/flameshot.nix
    ../../modules/home-manager/services/picom.nix
    ../../modules/home-manager/services/sxhkd.nix
    ../../modules/home-manager/programs/alacritty.nix
    ../../modules/home-manager/programs/kitty.nix
    ../../modules/home-manager/programs/obs.nix
    ../../modules/home-manager/programs/rofi.nix
  ];

  home.file.".config/qtile".source = ./../../dotfiles/qtile;
#  file.".config/wall".source = ../modules/themes/wall;
#  file.".config/wall.mp4".source = ../modules/themes/wall.mp4;

  home = {
    packages = with pkgs; [
      rofi
      rofi-power-menu
      rofi-calc
      rofi-emoji
      dmenu
#      vscodium
      brave
      epiphany
      chromium
      google-chrome
      google-chrome-dev
#      firefox
      firefox-devedition
      librewolf
      nitrogen
      thunderbird
      libsForQt5.breeze-gtk
      _1password-gui
      signal-desktop
      slack
      telegram-desktop
      skypeforlinux
      discord
      freetube
      ruby
      zoom-us
      teams-for-linux
      caffeine-ng
      gnome.gnome-disk-utility
      junction
      rose-pine-gtk-theme
      rose-pine-icon-theme
      clockify
      mailspring
    ];

    # pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
    #   gtk.enable = true;
    #   #name = "Dracula-cursors";
    #   name = "Catppuccin-Mocha-Dark-Cursors";
    #   #package = pkgs.dracula-theme;
    #   package = pkgs.catppuccin-cursors.mochaDark;
    #   size = 16;
    # };
  };

  #programs = {
  #  home-manager.enable = true;
 # };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "rose-pine";
      # package = pkgs.adw-gtk3;
      # name = "adw-gtk3";
    };
    cursorTheme = {
      name = "BreezeX-Light";
      size = 28;
    };
    iconTheme = {
      name = "maia-dark";
      # package = gruvboxPlus;
      # name = "GruvboxPlus";
    };
  };

  systemd.user.targets.tray = {               # Tray.target can not be found when xsession is not enabled. This fixes the issue.
   Unit = {
     Description = "Home Manager System Tray";
     Requires = [ "graphical-session-pre.target" ];
    };
  };
}
