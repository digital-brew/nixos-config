{ config, lib, pkgs, inputs, ... }:

{
  imports = [];

  home.username = "moonlander";
  home.homeDirectory = "/home/moonlander";

  home.packages = [];

  home.stateVersion = "23.11";
}