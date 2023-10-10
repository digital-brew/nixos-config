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
    swww
    rofi-wayland
    libglvnd
    wlroots
    grim
    slurp
    wl-clipboard
    waybar
    swappy
#    eww-wayland
#    (eww-wayland.overrideAttrs (drv: rec {
#      version = "tray-3";
#      src = fetchFromGitHub {
#        owner = "ralismark";
#          repo = "eww";
#          rev = "ef386fc1a3b7736603d55a2157aa1059be373aeb";
#          hash = "sha256-0v3bxnC0i6kNXbkIKkUXXZEesMwZg79z7T8kA0oDZsM=";
#      };
#      cargoDeps = drv.cargoDeps.overrideAttrs (lib.const {
#        inherit src;
#        outputHash = "sha256-DLe+bVzc8Gr5MOubR/zzLUl7NRI9uxguWtMCAOcxC4A=";
#      });
#
#      buildInputs = drv.buildInputs ++ (with pkgs; [ glib librsvg libdbusmenu-gtk3 rustc ]);
#    }))
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}