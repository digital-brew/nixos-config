{ config, lib, pkgs, inputs, main-user, ... } @ args:
let
  hardwareConfiguration = ./hardware-configuration.nix;
  nixosModules = ../../modules/nixos;
  nixosOverlays = ../../overlays/nixos;
  homeManagerModules = ../../modules/home-manager;
  homeManagerOverlays = ../../overlays/home-manager;
in
{
  # Imports
  imports = [
    hardwareConfiguration
    nixosModules
    homeManagerModules
    nixosOverlays
  ];

  # Modules
  modules = {
    apple = {
      brcm.enable = false;
      fans.enable = false;
      sound.enable = false;
    };
    browsers.enable = true;
    design.enable = false;
    desktop = {
      displayManager.enable = true;
      gnome.enable = true;
      hyprland.enable = true;
      sddm.enable = true;
      themes.enable = false;
      wayland.enable = true;
      xserver.enable = true;
    };
    devenv.enable = true;
    flatpak.enable = false;
    nixAlien.enable = false;
    media.enable = true;
    office.enable = false;
    qemu.enable = false;
    samba.enable = false;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs main-user; };
    users = {
      "${main-user.username}" = import ./home.nix;
    };
  };

  programs.git.enable = true;
}
