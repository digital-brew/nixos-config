# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: TERMINAL: ZSH
# Type: Module (HomeManager)
# Location: /modules/terminal/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
in
{
  config = lib.mkIf config.customModules.terminal.enable {
    home-manager.users.${username} = {
      programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        enableVteIntegration = true;
        initExtra = ''
          zsh -c 'neofetch'
          export PATH="$HOME/.npm-packages/bin:$PATH"
          export NVM_DIR="$HOME/.nvm"
          [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
          export PATH=$PATH:/run/current-common/sw/bin/python3
          export PATH=$PATH:$HOME/.config/scripts
          '';
        envExtra = "eval \"$(direnv hook zsh)\"";
        syntaxHighlighting = {
          enable = true;
        };
        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "sudo"
          ];
          theme = "robbyrussell";
        };
      };
    };
  };
}
