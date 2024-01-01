{ config, lib, pkgs, inputs, main-user, ... }:

{
  imports = [];

  home.username = main-user.username;
  home.homeDirectory = main-user.home-dir;

  home.packages = [];

  home.stateVersion = "23.11";
}
