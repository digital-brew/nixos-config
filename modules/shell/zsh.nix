{ config, lib, pkgs, ... }:
let

in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    initExtra = "zsh -c 'neofetch'";
    envExtra = "eval \"$(direnv hook zsh)\"";
    shellAliases = {

    };
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
}