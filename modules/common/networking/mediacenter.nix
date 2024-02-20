# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: VIRTUALMACHINE NETWORKING (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/networking/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, hostName, machineName, ... }:

{
  config = (lib.mkIf (machineName == "mediacenter") {
    networking.hostName = "DB-MCi7MBP";
    networking.networkmanager = {
      enable = true;
      wifi = {
        scanRandMacAddress = false;
      };
    };
    networking.useDHCP = lib.mkDefault false;
    networking.defaultGateway = "192.168.1.1";
    networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 631 ];
      allowedUDPPorts = [ 22 80 443 631 ];
    };
  });
}
