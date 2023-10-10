#
# Patch to enable IPv6 for Dell D6000 Docking Station
#

{ config, pkgs, lib, ... }:

{
  # source: https://nixos.wiki/wiki/Hardware/Dell/D6000_Universal_Dock
  boot.kernelPatches = lib.singleton {
    name = "enable-d6000";
    patch = [
      ./0001-Hook-into-usbnet_change_mtu-respecting-usbnet-driver.patch
      ./0002-Admit-multicast-traffic.patch
    ];
  };
}