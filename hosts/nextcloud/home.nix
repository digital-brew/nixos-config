{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/programs/alacritty.nix
    ../../modules/home-manager/programs/kitty.nix
#    ../../modules/home-manager/programs/ssh.nix
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

  home = {
    packages = with pkgs; [];

    pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      gtk.enable = true;
      name = "Breeze_Snow";
      package = pkgs.libsForQt5.breeze-gtk;
      size = 16;
    };
  };

  programs = {};

  services = {};

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
}
