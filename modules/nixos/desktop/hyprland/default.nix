{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland service";
  };

  config = mkIf config.modules.desktop.hyprland.enable {
    programs.hyprland = {
      enable = true;
      enableNvidiaPatches = false;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    hardware = {
      opengl.enable = true;
    };

    environment.systemPackages = with pkgs; [
      hyprland-autoname-workspaces
      hyprnome
      hyprpaper
      hyprpicker
      pyprland
    ];
  };
}
