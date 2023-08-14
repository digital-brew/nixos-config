{ config, lib, pkgs, ... }:
let
 
in
{
  programs.git = {
    enable = true;
    extraConfig = {
      user = {
        name = "digital-brew";
        email = "rafal+github@digitalbrew.io";
      };

      core = {
        autocrlf = "input";
      };

#      [filter "lfs"]
#      	process = git-lfs filter-process
#      	required = true
#      	clean = git-lfs clean -- %f
#      	smudge = git-lfs smudge -- %f
#      [init]
#      	defaultBranch = main
    };
  };
}