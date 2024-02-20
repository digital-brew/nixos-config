# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: WORK BOOTLOADER (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/bootloader/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, hostName, machineName, ... }:

{
  config = (lib.mkIf (machineName == "work") {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 40;
    };
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };
  });
}
