{ config, lib, pkgs, ... }:
let
 
in
{
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
}