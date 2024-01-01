{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.media = {
    enable = mkEnableOption "media service";
  };

  config = mkIf config.modules.media.enable {
    environment.systemPackages = with pkgs; [
      handbrake                                 # A tool for converting video files and ripping DVDs
      playerctl                                 # Command-line utility and library for controlling media players that implement MPRIS
      rhythmbox                                 # A music playing application for GNOME
      spotify                                   # Play music from the Spotify music service
      vlc                                       # Cross-platform media player and streaming server
    ];

    programs = {
     
    };
  };
}