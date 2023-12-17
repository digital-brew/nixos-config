{ config, pkgs, ... }:
{
  imports = [] ;
  home.username = "moonlander";
  home.homeDirectory = "/home/moonlander";

  home.packages = [];

  home.stateVersion = "23.05";
}