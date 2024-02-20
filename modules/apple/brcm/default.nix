# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: APPLE WIFI + BLUETOOTH + MULTITOUCH
# Type: Module (NixOS)
# Location: /modules/apple/brcm/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.apple.brcm = {
    enable = lib.mkEnableOption "Whether to enable Apple's WIFI, Bluetooth and Multitouch devices.";
  };

  config = lib.mkIf config.customModules.apple.brcm.enable {
    hardware.firmware = [
      (pkgs.stdenvNoCC.mkDerivation {
        name = "brcm-firmware";

        buildCommand = ''
          dir="$out/lib/firmware"
          mkdir -p "$dir"
          cp -r ${./source/firmware}/* "$dir"
        '';
      })
    ];
  };
}
