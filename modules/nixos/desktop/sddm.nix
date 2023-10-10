{ config, lib, pkgs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in
{
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "sugar-candy";
    settings = {
      General = {
        ScreenWidth = "1920";
        ScreenHeight = "1080";
        FormPosition = "center";
        CursorTheme = "Breeze_Snow";
        CursorSize = 16;
      };
    };
  };
#  services.greetd = {
#    enable = true;
#    settings = {
#      default_session = {
#        command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
#      };
#    };
#  };
#
#  environment.etc."greetd/environments".text = ''
#    Hyprland
#    sway
#  '';
#
#  programs.sway.enable = true;
}