#
# Screenshots
#

{ config, lib, pkgs, user, ... }:

{
  services = {                                    # sxhkd shortcut = Printscreen button (Print)
    flameshot = {
      enable = true;
      settings = {
        General = {                               # Settings
          savePath = "/home/${user}/Desktop/Screenshots";
          saveAsFileExtension = ".png";
          uiColor = "#2d0096";
          showHelp = "true";
          disabledTrayIcon = "false";              # Hide from systray
        };
      };
    };
  };
}