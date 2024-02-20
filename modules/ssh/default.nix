# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: SSH
# Type: Module (HomeManager)
# Location: /modules/ssh/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, inputs, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
in
{
  options.customModules.ssh = {
    enable = lib.mkEnableOption "Whether to enable ssh service.";
  };

  config = lib.mkIf config.customModules.ssh.enable {
    home-manager.users.${username} = {
      programs.ssh = {
        enable = true;
        extraConfig = ''
          UserKnownHostsFile ~/.ssh/known_hosts
        '';
      };

      services.ssh-agent.enable = true;

      programs.ssh.matchBlocks = {
        # GitHub DigitalBrew
        "git.digitalbrew.io" = {
          hostname = "github.com";
          forwardAgent = true;
          identityFile = "~/.ssh/id_ed_digitalbrew";
        };
        # GitHub MuchMore
        "git.muchmore.co" = {
          hostname = "github.com";
          forwardAgent = true;
          identityFile = "~/.ssh/id_ed_muchmore";
        };
        # GitHub MuchMore + WPEngine
        "git.wpengine.com" = {
          hostname = "github.com";
          forwardAgent = true;
          identityFile = "~/.ssh/id_ed_muchmore";
        };
        # MuchMore Servers
        "muchmore.servers" = {
          hostname = "35.246.57.231";
          forwardAgent = true;
          identityFile = "~/.ssh/id_ed_muchmore";
        };
        # GitHub Legacy
        "github_legacy" = {
          hostname = "github.com";
          forwardAgent = true;
          identityFile = "~/.ssh/id_rsa";
        };
      };
    };
  };
}
