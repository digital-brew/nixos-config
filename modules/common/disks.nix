# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: DISKS (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, pkgs, hostname, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
in
{
  services.udisks2.enable = true;
  home-manager.users.${username}.services.udiskie = {
    enable = true;
    automount = true;
    tray = "always";
  };
}
