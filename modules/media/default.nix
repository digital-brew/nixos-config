# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: MEDIA
# Type: Module (NixOS)
# Location: /modules/media/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.media = {
    enable = lib.mkEnableOption "Whether to enable all media programs and services.";
  };

  config = lib.mkIf config.customModules.media.enable {
    environment.systemPackages = with pkgs; [
      freetube                                  # An Open Source YouTube app for privacy
      handbrake                                 # A tool for converting video files and ripping DVDs
      libcanberra-gtk3
      playerctl                                 # Command-line utility and library for controlling media players that implement MPRIS
      rhythmbox                                 # A music playing application for GNOME
      spotify                                   # Play music from the Spotify music service
      vlc                                       # Cross-platform media player and streaming server
    ];

    services.mpd.enable = true;                 # A flexible, powerful daemon for playing music
  };
}
