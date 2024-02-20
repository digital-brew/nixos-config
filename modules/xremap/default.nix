# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: XREMAP
# Type: Module (HomeManager)
# Location: /modules/xremap/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, inputs, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
in
{
  options.customModules.xremap = {
    enable = lib.mkEnableOption "Whether to enable xremap service.";
  };

  config = lib.mkIf config.customModules.xremap.enable {
    home-manager.users.${username} = {
      services.xremap = {
        withWlroots = true;
        config = {
          keymap = [
            {
              name = "main remaps";
              remap = {
                super-y = {
                  launch = ["firefox"];
                };
              };
            }
            {
              name = "other remaps";
              remap = {
                "SUPER-J" = "down";
              };
              application = {
                "only" = "firefox";
              };
            }
          ];
        };
      };
    };
  };
}
