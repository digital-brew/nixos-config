{ config, pkgs, ... }:

let
  version = "1.3.0";
  better-discord = pkgs.appimageTools.wrapType2 {
    name = "BetterDiscord";
    src = pkgs.fetchurl {
      url = "https://github.com/BetterDiscord/Installer/releases/download/v${version}/BetterDiscord-Linux.AppImage";
      sha256 = "sha256-In5J6TWoJsFODDwMXd1lMg3341IZJD2OJebVtgISxP0=";
    };
  };
in {
  home.packages = [ better-discord ];
}