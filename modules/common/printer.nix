# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: PRINTER (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  services.printing.enable = true;

  # Enable CUPS to print documents
  services.avahi = {
    enable = true;
#    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
