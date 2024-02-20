# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: NEXTCLOUD NETWORKING (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/networking/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, hostName, machineName, ... }:

{
  config = (lib.mkIf (machineName == "nextcloud") {
    networking.hostName = "DBNC";
    networking.networkmanager.enable = true;
    networking.defaultGateway = "5.255.116.1";
    networking.nameservers = ["185.31.172.240" "5.255.125.240"];
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
    };
    networking.interfaces = {
      ens3 = {
        ipv4.addresses = [{
          address = "5.255.116.105";
          prefixLength = 24;
        }];
      };
    };
  });
}
