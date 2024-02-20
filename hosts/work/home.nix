# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: WORK: HOME
# Type: Config (NixOS)
# Location: /hosts/work/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ config, lib, pkgs, hostname, inputs, system, extraConfig, ... }:
let
  nixColors = inputs.nix-colors;
  nixColorsModule = nixColors.homeManagerModules.default;
  username = extraConfig.mainUser.username;
  homeDir = extraConfig.mainUser.homeDir;
  colorScheme = extraConfig.colorScheme;
in
{
  imports = [
    nixColorsModule
  ];

  colorScheme = nixColors.colorSchemes.${colorScheme};

  home.username = username;
  home.homeDirectory = homeDir;

  home.packages = [];

  programs.home-manager.enable = true;
  programs.btop.enable = true;
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  services.ssh-agent.enable = true;
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  services.nextcloud-client.enable = true;
  services.network-manager-applet.enable = true;

  # Tray.target can not be found when xsession is not enabled. This fixes the issue.
#  systemd.user.targets.tray = {
#    Unit = {
#      Description = "Home Manager System Tray";
#      Requires = [ "graphical-session-pre.target" ];
#    };
#  };

  home.stateVersion = "23.05";
}
