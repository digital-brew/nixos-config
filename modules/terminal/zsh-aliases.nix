# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: TERMINAL: ZSH ALIASES
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
      programs.zsh.shellGlobalAliases = {
        "c" = "clear";
        "cdx" = "cd /home/moonlander/nixos-config";
        "cd." = "cd /home/moonlander/.config";
        "cdc" = "cd /run/media/moonlander/SilverSSD/Work/Code";
        "cdp" = "cd /run/media/moonlander/SilverSSD/Work/Projects";
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

        "ngrok:mm" = "ngrok config add-authtoken 2S7RroJxsYQv182fUTUVy9NUglC_4oUmg7aHoQ8v2tKDKNmqc";
        "ngrok:db" = "ngrok config add-authtoken 2EXaqodLxyqnMYWW58pKDEDBZZ0_LQyENpi7WwdPHcrF7QbD";

        "profile:reload" = "source ~/.zshrc && clear";
      };
    };
  };
}
