{ config, lib, pkgs, ... }:

{
  services = {                                    # sxhkd shortcut = Printscreen button (Print)
    flameshot = {
      enable = true;
      settings = {
        General = {                               # Settings
          savePath = "/home/moonlander/screenshots";
          saveAsFileExtension = ".png";
          uiColor = "#2d0096";
          showHelp = "false";
          disabledTrayIcon = "false";              # Hide from systray
        };
      };
    };
  };
}