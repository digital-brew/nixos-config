# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: GIT
# Type: Module (HomeManager)
# Location: /modules/git/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, inputs, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
in
{
  options.customModules.git = {
    enable = lib.mkEnableOption "Whether to enable git service.";
  };

  config = lib.mkIf config.customModules.git.enable {
    home-manager.users.${username} = {
      programs.git = {
        enable = true;
        lfs.enable = true;
        extraConfig = {
          init = {
            defaultBranch = "main";
          };
          user = {
            name = "digital-brew";
            email = "rafal+github@digitalbrew.io";
          };

          core = {
            autocrlf = "input";
            excludesfile = "~/.config/git/ignore";
          };
        };
        ignores = [
          # Nix development
          ".devenv"
          ".envrc"
          "devenv.local.nix"
          ".devenv.flake.nix"
          "devenv.lock"
          "devenv.nix"
          "devenv.yaml"
          ".direnv"

          # pre-commit
          ".pre-commit-config.yaml"

          # IDE's
          ".idea"
          ".vscode"

          # OS related
          ".DS_Store"
          "._*"
          ".Spotlight-V100"
          ".Trashes"
          "ehthumbs.db"
          "Thumbs.db"

          # Deps
          "node_modules"
        ];
      };
    };
  };
}
