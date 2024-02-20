# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: FONTS (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
    antialias = true;
    subpixel.rgba = "rgb";
    hinting = {
      enable = true;
      style = "full";
    };
    defaultFonts.serif = [ "Be Vietnam Pro, Semibold" ];
    defaultFonts.sansSerif = [ "Be Vietnam Pro, Semibold" ];
#    defaultFonts.monospace = [ "Fira Code" ];
    defaultFonts.monospace = [ "Hack Nerd Font Propo" ];
  };

#  console.font = "Hack Nerd Font Propo";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    google-fonts
    ubuntu_font_family
    nerdfonts
    font-awesome_5
    material-icons
  ];
}
