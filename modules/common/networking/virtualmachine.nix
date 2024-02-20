# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: VIRTUALMACHINE NETWORKING (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/networking/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, hostName, machineName, ... }:

{
  config = (lib.mkIf (machineName == "virtualmachine") {
    networking.hostName = "NixOS-VM";
    networking.networkmanager.enable = true;
  });
}
