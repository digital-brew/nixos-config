{ config, lib, pkgs, ... }:

{
  services.xserver.displayManager = {
    defaultSession = "none+qtile";
    setupCommands = ''
      SCREEN_0="eDP-1"
      SCREEN_1="DP-2"
      SCREEN_2="DVI-I-1-1"
      SCREEN_3="DVI-I-2-2"

      if ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr | grep "$SCREEN_1 connected"; then
          ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --output $SCREEN_0 --off --output $SCREEN_1 --mode 1920x1080 --output $SCREEN_2 --primary --mode 1920x1080 --left-of $SCREEN_1 --output $SCREEN_3 --mode 1920x1080 --right-of $SCREEN_1 &
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
}