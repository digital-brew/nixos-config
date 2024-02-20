# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: MIME-TYPES (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, pkgs, hostname, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
in
{
  home-manager.users.${username}.xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/jpg" = ["libsForQt5.gwenview.desktop" "image-roll.desktop"];
        "image/jpeg" = ["libsForQt5.gwenview.desktop" "image-roll.desktop"];
        "image/png" = ["libsForQt5.gwenview.desktop" "image-roll.desktop"];
        "image/gif" = ["libsForQt5.gwenview.desktop" "image-roll.desktop"];
        "text/plain" = "gnome-text-editor.desktop";
        "text/html" = "phpstorm.desktop";
        "text/csv" = "scalc.desktop";
        "application/pdf" = ["okular.desktop" "brave-browser.desktop" "firefox.desktop"];
        "application/zip" = "cinnamon.nemo-fileroller.desktop";
        "application/x-tar" = "cinnamon.nemo-fileroller.desktop";
        "application/x-bzip2" = "cinnamon.nemo-fileroller.desktop";
        "application/x-gzip" = "cinnamon.nemo-fileroller.desktop";
        "x-scheme-handler/http" = ["re.sonny.Junction.desktop" "brave-browser.desktop" "firefox.desktop"];
        "x-scheme-handler/https" = ["re.sonny.Junction.desktop" "brave-browser.desktop" "firefox.desktop"];
        "x-scheme-handler/about" = ["re.sonny.Junction.desktop" "brave-browser.desktop" "firefox.desktop"];
        "x-scheme-handler/unknown" = ["re.sonny.Junction.desktop" "brave-browser.desktop" "firefox.desktop"];
        "audio/mp3" = "vlc.desktop";
        "video/mp4" = "vlc.desktop";
        "video/x-matroska" = "vlc.desktop";
        "inode/directory" = "nemo.desktop";
      };

      associations.added = {
        "x-scheme-handler/https" = ["brave-browser.desktop"];
        "x-scheme-handler/http" = ["brave-browser.desktop"];
      };
    };
    desktopEntries.gwenview = {
      name = "gwenview";
      exec = "${pkgs.gwenview}/bin/gwenview %F";
      mimeType = ["image/*"];
    };
  };
}
