# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: WAYLAND
# Type: Module (NixOS)
# Location: /modules/desktop/wayland/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, inputs, system, ... }:
let
  wayland = inputs.nixpkgs-wayland.packages.${system};
in
{
  options.customModules.desktop.wayland = {
    enable = lib.mkEnableOption "Whether to enable Wayland, the replacement for the X11 and it's plugins.";
  };

  config = lib.mkIf config.customModules.desktop.wayland.enable {
    programs.xwayland.enable = true;

    security.pam.services.swaylock = {};

    environment.systemPackages = [
      wayland.eww-wayland
      wayland.grim
#      wayland.shotman
      wayland.slurp
#      wayland.swaylock
      wayland.swaylock-effects
      wayland.swww
      wayland.wf-recorder
#      wayland.wl-clipboard
      wayland.wl-screenrec
#      wayland.wldash
      wayland.wlr-randr
      wayland.wlroots
      wayland.wlsunset
#      wayland.wtype
#      pkgs.eww-wayland
#      pkgs.grim
#      pkgs.shotman
#      pkgs.slurp
#      pkgs.swaylock
#      pkgs.swaylock-effects
#      pkgs.swww
#      pkgs.wf-recorder
#      pkgs.wl-clipboard
#      pkgs.wl-screenrec
#      pkgs.wlr-randr
#      pkgs.wlroots
#      pkgs.wlsunset
#      pkgs.wtype
      pkgs.rofi-wayland
      pkgs.libglvnd
      pkgs.nwg-look                                  # Nwg-look is a GTK3 settings editor, designed to work properly in wlroots-based Wayland environment.
      pkgs.cliphist
#      pkgs.pywal
      pkgs.workstyle
      pkgs.nwg-displays
      pkgs.grimblast
    ];
  };
}
