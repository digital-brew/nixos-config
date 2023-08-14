{ config, pkgs, ... }:

let
  notion = pkgs.appimageTools.wrapType2 {
    name = "Notion";
    src = pkgs.fetchurl {
      url = "https://github.com/Johoski/WebToApp/releases/download/notion/Notion-x86_64.AppImage";
      sha256 = "sha256-ymOAMrg9CwUcRPZa227rX20893/11FTMeC+ty1KfQ3s=";
    };
  };
in {
  home.packages = [ notion ];
}