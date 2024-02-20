# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: BROWSERS
# Type: Module (NixOS)
# Location: /modules/browsers/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.browsers = {
    enable = lib.mkEnableOption "Whether to enable all browsers.";
  };

  config = lib.mkIf config.customModules.browsers.enable {
    environment.systemPackages = with pkgs; [
      brave                                         # Privacy-oriented browser for Desktop and Laptop computers
      epiphany                                      # WebKit based web browser for GNOME
      floorp                                        # A fork of Firefox, focused on keeping the Open, Private and Sustainable Web alive, built in Japan
      google-chrome                                 # A freeware web browser developed by Google
      junction                                      # Choose the application to open files and links
      librewolf                                     # A fork of Firefox, focused on privacy, security and freedom
    ];

    programs = {
      chromium.enable = true;                       # An open source web browser from Google
      firefox.enable = true;                        # Mozilla Firefox, free web browser
    };
  };
}
