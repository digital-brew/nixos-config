{ config, pkgs, ... }:
{
  # imports = [
  #   ../../modules/home-manager/browsers
  # ] ;
  home.username = "moonlander";
  home.homeDirectory = "/home/moonlander";

  home.packages = [];

  home.stateVersion = "23.11";
}