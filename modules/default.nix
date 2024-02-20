# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: MODULES
# Type: Imports (NixOS)
# Location: /modules/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  imports = [
    ./appimage
    ./apple/brcm
    ./apple/fans
    ./apple/sound
    ./browsers
    ./common
    ./communication
    ./design
    ./desktop/display-manager
    ./desktop/dunst
    ./desktop/eww
    ./desktop/gdm
    ./desktop/gnome
    ./desktop/hyprland
    ./desktop/qtile
    ./desktop/picom
    ./desktop/rofi
    ./desktop/sddm
    ./desktop/themes
    ./desktop/waybar
    ./desktop/wayland
    ./desktop/xfce
    ./desktop/xserver
    ./devenv
    ./email
    ./flatpak
    ./git
    ./nix-alien
    ./media
    ./office
    ./qemu
    ./samba
    ./ssh
    ./swappy
#    ./symlinks
    ./terminal
    ./xremap
  ];
}
