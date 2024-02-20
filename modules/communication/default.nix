# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: COMMUNICATION
# Type: Module (NixOS)
# Location: /modules/communication/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.communication = {
      enable = lib.mkEnableOption "Whether to enable all programs and services for communication.";
    };

  config = lib.mkIf config.customModules.communication.enable {
    environment.systemPackages = with pkgs; [
      discord                                   # All-in-one cross-platform voice and text chat for gamers
      signal-desktop                            # Private, simple, and secure messenger
      skypeforlinux                             # Linux client for skype
      slack                                     # Desktop client for Slack
      telegram-desktop                          # Telegram Desktop messaging app
      zoom-us                                   # zoom.us video conferencing application
    ];
  };
}
