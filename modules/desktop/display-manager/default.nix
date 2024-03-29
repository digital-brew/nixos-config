# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: DISPLAY MANAGER
# Type: Module (NixOS)
# Location: /modules/desktop/display-manager/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.desktop.displayManager = {
    enable = lib.mkEnableOption "Whether to enabiel display manager service.";
  };

  config = lib.mkIf config.customModules.desktop.displayManager.enable {
    services.xserver.displayManager = {
#        defaultSession = "gnome";
        defaultSession = "hyprland";
        setupCommands = ''
          SCREEN_0="eDP-1"
          SCREEN_1="DP-4"
          SCREEN_2="DP-5"
          SCREEN_3="DP-6"

          # Set screens placement and resolution
          if ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr | grep "$SCREEN_1 connected"; then
              ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --output $SCREEN_0 --off --output $SCREEN_1 --mode 1920x1080 --output $SCREEN_2 --primary --mode 1920x1080 --right-of $SCREEN_1 --output $SCREEN_3 --mode 1920x1080 --right-of $SCREEN_2 &
          else
              ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --output $SCREEN_0 --mode 1440x900 &
          fi
        '';
        sessionCommands = ''
          ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
          ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
              Xcursor.theme: BreezeX-Light
              Xcursor.size: 28
            ''}
        '';
      };
  };
}
