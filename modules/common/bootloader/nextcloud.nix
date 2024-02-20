# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: NEXTCLOUD BOOTLOADER (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/bootloader/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, hostName, machineName, ... }:

{
  config = (lib.mkIf (machineName == "nextcloud") {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 40;
    };
  });
}
