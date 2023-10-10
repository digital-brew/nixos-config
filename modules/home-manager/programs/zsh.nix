{ config, lib, pkgs, ... }:
let

in
{
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
      export PATH=$PATH:/run/current-system/sw/bin/python3
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
    shellAliases = {

    };
  };
}