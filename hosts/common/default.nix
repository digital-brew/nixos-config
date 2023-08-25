{ pkgs, lib, ... }:

{
  imports = [
    ./configuration.nix
    ./overlays.nix
    ../../modules/nixos/desktop/display-manager.nix
    ../../modules/nixos/desktop/qtile.nix
    ../../modules/nixos/desktop/sddm.nix
    ../../modules/nixos/services/ssh.nix
    ../../modules/nixos/services/flatpak.nix
  ];
}