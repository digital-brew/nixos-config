# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: TERMINAL: KITTY
# Type: Module (HomeManager)
# Location: /modules/terminal/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
in
{
  config = lib.mkIf config.customModules.terminal.enable {
    home-manager.users.${username} = {
      programs.kitty = {
        enable = true;
        font = {
          name = "Ubuntu Mono";
          size = 14;
        };
        theme = "Catppuccin-Mocha";
        shellIntegration = {
          enableZshIntegration = true;
        };
      };
    };
  };
}
