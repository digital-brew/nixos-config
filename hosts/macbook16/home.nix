{ config, lib, pkgs, ... }:
let
  gruvboxPlus = import ./../../modules/themes/gruvbox-plus.nix { inherit pkgs; };
in
{
  imports = [
    ./../../modules/programs/alacritty.nix
#    ./../../modules/programs/kitty.nix
    ./../../modules/programs/git.nix
#    ./../../modules/programs/rofi.nix
#    ./../../modules/packages/cerbro.nix
#    ./../../modules/packages/table-plus.nix
    ./../../modules/packages/better-discord.nix
    ./../../modules/services/dunst.nix
    ./../../modules/services/picom.nix
    ./../../modules/services/flameshot.nix
#    ./../../modules/shell/ssh.nix
    ./../../modules/shell/zsh.nix
#    ./../../modules/themes/catppuccin.nix
  ];

#  home.packages = with pkgs; [pamixer];

  # Raw config files
  home.file.".config/qtile".source = ./../../dotfiles/qtile;
#  home.file.".xmodmaprc".source = ./../../dotfiles/xmodmaprc;

  # Theme settings
  gtk = {
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
  qt = {
    enable = true;
  };
}