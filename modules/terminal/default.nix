# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: TERMINAL
# Type: Imports (HomeManager)
# Location: /modules/terminal/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.terminal = {
    enable = lib.mkEnableOption "Whether to enable terminal: alacritty, kitty, zsh and other services.";
  };

  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./kitty.nix
    ./zsh.nix
    ./zsh-aliases.nix
    ./zsh-functions.nix
  ];
}
