{ config, lib, pkgs, ... }:

{ 
  imports = [
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
    btop.enable = true;                       # a monitor of system resources
    htop.enable = true;
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };

  services.ssh-agent.enable = true;
}
