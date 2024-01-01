{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.apple.brcm = {
    enable = mkEnableOption "apple wifi bluetooth and multitouch service";
  };

  config = mkIf config.modules.apple.brcm.enable {
    hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation {
      name = "brcm-firmware";

      buildCommand = ''
        dir="$out/lib/firmware"
        mkdir -p "$dir"
        cp -r ${./source}/* "$dir"
      '';
    })
  ];
  };
}