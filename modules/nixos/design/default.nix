{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.design = {
    enable = mkEnableOption "design services";
  };

  config = mkIf config.modules.design.enable {
    environment.systemPackages = with pkgs; [
      figma-linux                               # Unofficial Electron-based Figma desktop app for Linux
      krita                                     # A free and open source painting application
      inkscape                                  # Vector graphics editor
      blender                                   # 3D Creation/Animation/Publishing System
      gimp                                      # The GNU Image Manipulation Program
      darktable                                 # Virtual lighttable and darkroom for photographers
      libsForQt5.kdenlive                       # Video editor
      libsForQt5.gwenview                       # KDE image viewer

      # Figma deps
      figma-agent                               # Figma Agent for Linux (a.k.a. Font Helper)
    ];
  };
}