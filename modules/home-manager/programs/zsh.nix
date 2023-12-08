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
    shellGlobalAliases = {
      "c" = "clear";
      "cd:proj" = "cd /run/media/moonlander/SilverSSD/Work/Projects";
      "cd:fmm" = "cd /run/media/moonlander/SilverSSD/Work/Projects/mammarzenie.org/site";
      "cd:fmm:theme" = "cd /run/media/moonlander/SilverSSD/Work/Projects/mammarzenie.org/site/htdocs/content/themes/themosis";
      "cd:fmm:trellis" = "cd /run/media/moonlander/SilverSSD/Work/Projects/mammarzenie.org/trellis";
      "cd:stratus" = "cd /run/media/moonlander/SilverSSD/Work/Projects/stratus.earth/site";
      "cd:stratus:theme" = "cd /run/media/moonlander/SilverSSD/Work/Projects/stratus.earth/site/web/app/themes/sage";
      "cd:stratus:trellis" = "cd /run/media/moonlander/SilverSSD/Work/Projects/stratus.earth/trellis";
      "cd:arena" = "cd /run/media/moonlander/SilverSSD/Work/Projects/thearena.network/site";
      "cd:trimit" = "cd /run/media/moonlander/SilverSSD/Work/Projects/trimit.co.uk/site";
      "cd:ttc" = "cd /run/media/moonlander/SilverSSD/Work/Projects/shopify.theturmeric.co";
      "cd:ep" = "cd /run/media/moonlander/SilverSSD/Work/Projects/shopify.eternapure.com";

      "anv:encrypt" = "ansible-vault encrypt group_vars/all/vault.yml group_vars/local/vault.yml group_vars/staging/vault.yml group_vars/production/vault.yml";
      "anv:decrypt" = "ansible-vault decrypt group_vars/all/vault.yml group_vars/local/vault.yml group_vars/staging/vault.yml group_vars/production/vault.yml";
      "anv:encrypt-sage" = "ansible-vault encrypt group_vars/all/vault.yml group_vars/development/vault.yml group_vars/staging/vault.yml group_vars/production/vault.yml";
      "anv:decrypt-sage" = "ansible-vault decrypt group_vars/all/vault.yml group_vars/development/vault.yml group_vars/staging/vault.yml group_vars/production/vault.yml";

      "de:u" = "devenv up";
      "de:ud" = "devenv update";
      "de:s" = "devenv shell";
      "de:i" = "devenv init";

      "profile:reload" = "source ~/.zshrc && clear";
    };
  };
}