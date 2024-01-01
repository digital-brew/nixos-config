{ lib, config, pkgs, ... }:

{
  fonts = {
    fontconfig = {
      antialias = true;
      subpixel.rgba = "rgb";
      hinting = {
        enable = true;
        style = "full";
      };
      defaultFonts.serif = [ "Be Vietnam Pro, Semibold" ];
      defaultFonts.sansSerif = [ "Be Vietnam Pro, Semibold" ];
      defaultFonts.monospace = [ "Hack Nerd Font Propo" ];
    };
  packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    ubuntu_font_family
    nerdfonts
    font-awesome_5
    material-icons
    ];
  };
}
