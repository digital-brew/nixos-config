{ lib, config, pkgs, ... }:

{
  imports = [
    ./apple/brcm
    ./apple/fans
    ./apple/sound
    ./browsers
    ./common
    ./communication
    ./design
    ./desktop/display-manager
    ./desktop/gnome
    ./desktop/hyprland
    ./desktop/sddm
    ./desktop/themes
    ./desktop/wayland
    ./desktop/xserver
    ./devenv
    ./flatpak
    ./nix-alien
    ./media
    ./office
    ./qemu
    ./samba
  ];
}
