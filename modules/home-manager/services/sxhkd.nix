#
# Keyboard shortcuts
#

{ config, lib, pkgs, ... }:

{
  services = {
    sxhkd = {
      enable = false;
      keybindings = {
        # XF86 Keys
        "XF86AudioRaiseVolume" = "pw-volume change +2%";    # Raise volume
        "XF86AudioLowerVolume" = "pw-volume change -2%";    # Lower volume
        "XF86AudioMute" = "pw-volume mute toggle";          # Toggle mute audio
        "XF86AudioPlay" = "playerctl play-pause";           # Play/pause
        "XF86AudioRewind" = "playerctl previous";           # Previous Track
        "XF86AudioForward" = "playerctl next";              # Next track
      };
    };
  };
}