# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: APPIMAGE
# Type: Module (NixOS)
# Location: /modules/appimage/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.appimage = {
    enable = lib.mkEnableOption "appimage service";
  };

  config = lib.mkIf config.customModules.appimage.enable {
    boot.binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    environment.systemPackages = with pkgs; [
      appimage-run                                              # Run appimage packages on NixOS
    ];
  };
}
