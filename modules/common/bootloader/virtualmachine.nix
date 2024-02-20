# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: VIRTUALMACHINE BOOTLOADER (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/bootloader/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, hostName, machineName, ... }:

{
  config = (lib.mkIf (machineName == "virtualmachine") {
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/vda";
    boot.loader.grub.useOSProber = true;

    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 40;
    };
  });
}
