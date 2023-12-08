{ config, lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = false;
    xwayland.enable = true;
  };

  programs.xwayland.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
  };

  environment.systemPackages = with pkgs; [
#    swww
    rofi-wayland
    libglvnd
#    wlroots
#    grim
    sway
#    slurp
#    wl-clipboard
#    wf-recorder
#    waybar
    swappy
    pywal
    workstyle
    hyprland-autoname-workspaces
    hyprnome
    hyprpaper
    hyprpicker
    nwg-displays
    grimblast
    pyprland
  ];

#  xdg.portal.enable = true;
#  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}