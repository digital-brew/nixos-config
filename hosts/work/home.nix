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
    ../../modules/home-manager/programs/git.nix
  ];

  # home.file.".config/qtile".source = ./../../dotfiles/qtile;
#  file.".config/wall".source = ../modules/themes/wall;
#  file.".config/wall.mp4".source = ../modules/themes/wall.mp4;

#  home.file.".ssh/id_ed_digitalbrew".source = ./../../dotfiles/ssh/id_ed_digitalbrew;
#  home.file.".ssh/id_ed_digitalbrew.pub".source = ./../../dotfiles/ssh/id_ed_digitalbrew.pub;
#  home.file.".ssh/id_ed_muchmore".source = ./../../dotfiles/ssh/id_ed_muchmore;
#  home.file.".ssh/id_ed_muchmore.pub".source = ./../../dotfiles/ssh/id_ed_muchmore.pub;
#  home.file.".ssh/id_rsa".source = ./../../dotfiles/ssh/id_rsa;
#  home.file.".ssh/id_rsa.pub".source = ./../../dotfiles/ssh/id_rsa.pub;

  home.file.".npmrc".source = ./../../dotfiles/node/npmrc;

  home = {
    packages = with pkgs; [
      dmenu
      brave
      epiphany
      google-chrome
      google-chrome-dev
      librewolf
      nitrogen
      _1password-gui
      signal-desktop
      slack
      telegram-desktop
      skypeforlinux
      discord
      freetube
      ruby
      caffeine-ng
      gnome.gnome-disk-utility
      junction
      rose-pine-gtk-theme
      rose-pine-icon-theme
      clockify
      mailspring
    ];

    pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      gtk.enable = true;
      name = "Breeze_Snow";
      package = pkgs.libsForQt5.breeze-gtk;
      size = 16;
    };
  };

  programs = {
   chromium.enable = true;
   firefox.enable = true;
   direnv = {
    enable = true;
    enableZshIntegration = true;
   };                     # shell extension that manages your environment
   jq.enable = true;
   sioyek.enable = true;                      # PDF reader
#   vscode = {
#    enable = true;
#   };
  };

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    nextcloud-client.enable = true;
    network-manager-applet.enable = true;
  };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Adwaita-dark";
    };
    iconTheme = {
      name = "Adwaita";
    };
  };

  qt = {
    enable = true;
  };

  systemd.user.targets.tray = {               # Tray.target can not be found when xsession is not enabled. This fixes the issue.
   Unit = {
     Description = "Home Manager System Tray";
     Requires = [ "graphical-session-pre.target" ];
    };
  };

#  programs.eww = {
#    enable = true;
#    package = pkgs.eww;
#    configDir = ./../../../../../home/moonlander/.config/eww;
#  };
}
