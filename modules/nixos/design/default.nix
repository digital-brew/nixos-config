{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.design = {
    enable = mkEnableOption "design services";
  };

  config = mkIf config.modules.design.enable {
    environment.systemPackages = with pkgs; [
      krita
      inkscape
      blender
      gimp
      darktable
      libsForQt5.kdenlive
      libsForQt5.gwenview
    ];

    programs = {
     
    };
  };
}