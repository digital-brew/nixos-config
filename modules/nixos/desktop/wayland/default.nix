{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.desktop.wayland = {
    enable = mkEnableOption "wayland service";
  };

  config = mkIf config.modules.desktop.wayland.enable {
    programs.xwayland.enable = true;

    environment.systemPackages = with pkgs; [
      rofi-wayland
      libglvnd
      sway
      swappy
      pywal
      workstyle
      nwg-displays
      grimblast
    ];
  };
}
