{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/programs/git.nix
    ../../modules/home-manager/programs/zsh.nix
  ];

  home = {
    username = "nextcloud";
    homeDirectory = "/home/nextcloud";

    packages = with pkgs; [
      dconf
    ];

    stateVersion = "23.05";
  };

  programs = {
    home-manager.enable = true;
  };

  services = {};
}
