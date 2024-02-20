# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: DESIGN
# Type: Module (NixOS)
# Location: /modules/design/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.design = {
    enable = lib.mkEnableOption "Whether to enable all design programs and services.";
  };

  config = lib.mkIf config.customModules.design.enable {
    environment.systemPackages = with pkgs; [
      blender                                   # 3D Creation/Animation/Publishing System
      darktable                                 # Virtual lighttable and darkroom for photographers
      figma-linux                               # Unofficial Electron-based Figma desktop app for Linux
      gimp                                      # The GNU Image Manipulation Program
      image-roll                                # Simple and fast GTK image viewer with basic image manipulation tools
      imagemagick                               # A software suite to create, edit, compose, or convert bitmap images
      inkscape                                  # Vector graphics editor
      krita                                     # A free and open source painting application
      libsForQt5.kdenlive                       # Video editor
      libsForQt5.gwenview                       # KDE image viewer

      # Figma deps
      figma-agent                               # Figma Agent for Linux (a.k.a. Font Helper)
    ];
  };
}
