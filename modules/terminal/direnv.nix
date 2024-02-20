# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: TERMINAL: DIRENV
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
      # shell extension that manages your environment
      programs.direnv.enable = true;
      programs.direnv.enableZshIntegration = true;
    };
  };
}
