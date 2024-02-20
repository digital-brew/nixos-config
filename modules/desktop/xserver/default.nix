# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: XSERVER
# Type: Module (NixOS)
# Location: /modules/desktop/xserver/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.desktop.xserver = {
    enable = lib.mkEnableOption "Whether to enable the X server.";
  };

  config = lib.mkIf config.customModules.desktop.xserver.enable {
    services.xserver.enable = true;
    services.xserver.xkb.layout = "pl";
    services.xserver.xkb.variant = "";
#    # release-23.11
#    services.xserver.layout = "pl";
#    services.xserver.xkbVariant = "";

    services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  };
}
