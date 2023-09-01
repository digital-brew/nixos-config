{ pkgs, lib, ... }:

{
  programs.ssh = {
    enable = true;
#    matchBlocks = {
#      # GitHub DigitalBrew
#      "git.digitalbrew.io" = {
#        hostname = "github.com";
#        forwardAgent = true;
#        identifyFile = "~/.ssh/id_ed_digitalbrew";
#      };
#      # GitHub MuchMore
#      "git.muchmore.co" = {
#        hostname = "github.com";
#        forwardAgent = true;
#        identifyFile = "~/.ssh/id_ed_muchmore";
#      };
#      # GitHub MuchMore + WPEngine
#      "git.wpengine.com" = {
#        hostname = "github.com";
#        forwardAgent = true;
#        identifiesOnly = true;
#        identifyFile = "~/.ssh/id_ed_muchmore";
#      };
#      # MuchMore Servers
#      "muchmore.servers" = {
#        hostname = "35.246.57.231";
#        forwardAgent = true;
#        identifyFile = "~/.ssh/id_ed_muchmore";
#      };
#      # GitHub Legacy
#      "github_legacy" = {
#        hostname = "github.com";
#        forwardAgent = true;
#        identifyFile = "~/.ssh/id_rsa";
#      };
#    };
  };
}