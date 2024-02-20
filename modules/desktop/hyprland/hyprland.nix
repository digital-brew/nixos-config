# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: HYPRLAND
# Type: Module (NixOS)
# Location: /modules/desktop/hyprland/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, system, inputs, ... }:

{
  options.customModules.desktop.hyprland = {
    enable = lib.mkEnableOption "Whether to enable the Hyprland, the dynamic tiling Wayland compositor.";
  };

  config = lib.mkIf config.customModules.desktop.hyprland.enable {

    programs.hyprland = {
      enable = true;
    };

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      xdg-desktop-portal-hyprland
#      hyprland-autoname-workspaces
#      hyprnome
#      hyprpaper
#      hyprpicker
#      pyprland
    ];

    hardware = {
      opengl.enable = true;
    };

#    programs.hyprland.settings = {
#      exec-once = [
#        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
#        "swww init"
#        "nm-applet --indicator"
#        "dunst"
#        "~/nixos-config/dotfiles/scripts/disable-laptop-screen.sh"
#        "~/.config/waybar/launch.sh"
#      ];
#    };
  };
}
