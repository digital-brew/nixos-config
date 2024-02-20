# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: WORK: CONFIGURATION
# Type: Config (NixOS)
# Location: /hosts/work/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ config, pkgs, hostname, inputs, system, extraConfig, ... }:
  let
    hardwareConfiguration = ./hardware-configuration.nix;
    nixosAppleHardware = inputs.nixos-hardware.nixosModules.apple-t2;
    homeManagerModule = inputs.home-manager.nixosModules.default;
    localHosts = ./hosts.nix;
    customModules = ../../modules;
    customOverlays = ../../overlays;
    customPackages = ../../packages;
    dellDockPatch = ../../patches/dell-d6000-ethernet/patch.nix;
    username = extraConfig.mainUser.username;
    colorScheme = extraConfig.colorScheme;
  in
{
  imports = [
    hardwareConfiguration
    nixosAppleHardware
    homeManagerModule
    localHosts
    customModules
    customOverlays
    customPackages
    dellDockPatch
  ];

  customModules = {
    appimage.enable = true;
    apple = {
      brcm.enable = true;
      fans.enable = true;
      sound.enable = true;
    };
    browsers.enable = true;
    communication.enable = true;
    design.enable = true;
    desktop = {
      displayManager.enable = true;
      dunst.enable = true;
      eww.enable = true;
      gdm.enable = false;
      gnome.enable = true;
      hyprland.enable = true;
      qtile.enable = false;
      picom.enable = false;
      rofi.enable = true;
      sddm.enable = true;
      themes.enable = false;
      waybar.enable = true;
      wayland.enable = true;
      xfce.enable = false;
      xserver.enable = true;
    };
    devenv.enable = true;
    email.enable = true;
    flatpak.enable = false;
    git.enable = true;
    nixAlien.enable = true;
    media.enable = true;
    office.enable = true;
    qemu.enable = true;
    samba.enable = true;
    ssh.enable = true;
    swappy.enable = true;
    terminal.enable = true;
    xremap.enable = false;
  };

  myPackages = {
    appleWifiBluetooth.enable = false;
    applet2fand.enable = true;
    chatGPT.enable = false;
    hyprlandWorkspaces.enable = true;
    spatieRay.enable = true;
    stripeCli.enable = true;
    themes.sddm.sugarCandy.enable = true;
    trellisCli.enable = true;
    thoriumBrowser.enable = true;
    ulauncher.enable = false;
  };

  home-manager = {
    extraSpecialArgs = { inherit hostname inputs system extraConfig; };
    users = {
      "${username}" = import ./home.nix;
    };
  };
}
