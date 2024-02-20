# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: WORK NETWORKING (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/networking/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, hostName, machineName, ... }:

{
  config = (lib.mkIf (machineName == "work") {
    systemd.network.wait-online.enable = false;

    networking.hostName = "DBi9XRL";
    networking.networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        scanRandMacAddress = false;
      };
    };
    networking.useDHCP = lib.mkDefault false;
    networking.defaultGateway = "192.168.1.1";
    networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 631 3456 32016 4040 2019 57621 65432 ];
      allowedUDPPorts = [ 22 80 443 631 3456 32016 4040 2019 5353 65432 ];
    };

    environment.systemPackages = with pkgs; [
      networkmanager
      networkmanager_dmenu
    ];
  });
}
