{ config, lib, pkgs, ... }:

{ 
  imports = [
    ../../modules/home-manager/services/udiskie.nix
    ../../modules/home-manager/programs/git.nix
    ../../modules/home-manager/programs/zsh.nix
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
