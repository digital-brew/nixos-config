{ pkgs, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/nixos/desktop/display-manager.nix
#    ../../modules/nixos/desktop/qtile.nix
    ../../modules/nixos/desktop/hyprland.nix
#    ../../modules/nixos/desktop/wayland.nix
    ../../modules/nixos/desktop/sddm.nix
#    ../../modules/nixos/services/flatpak.nix
  ];
}
