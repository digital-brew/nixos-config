{ config, lib, pkgs, ... }:

{ 
  imports = [
  #  ../../modules/home-manager/services/udiskie.nix
  ];

  home = {
    username = "moonlander";
    homeDirectory = "/home/moonlander";

    packages = with pkgs; [
	    dconf
    ];

    stateVersion = "23.05";
  };

  programs = {
    home-manager.enable = true;
  };
}
