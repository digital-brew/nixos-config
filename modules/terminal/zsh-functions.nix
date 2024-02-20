# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: TERMINAL: ZSH FUNCTIONS
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
      programs.zsh.initExtra = ''
        app() {
          # Change to the Projects directory
          cd /run/media/moonlander/SilverSSD/Work/Projects || return

          # Check if there is a folder containing the name of the first argument
          project_dir=$(find . -type d -name "*$1*" -print -quit)
          if [[ -z "$project_dir" ]]; then
            echo "No project found for $1"
            return
          fi

          # Change to the found directory
          cd "$project_dir" || return

          # When a second argument is provided
          if [[ -n "$2" ]]; then
            case "$2" in
              site|trellis)
                if [[ -d "$project_dir/$2" ]]; then
                  cd "$project_dir/$2" || return
                else
                  echo "Subfolder $2 not found for $project_dir"
                  return
                fi
                ;;
              theme)
                if [[ -d "$project_dir/site/web/app/themes/sage" ]]; then
                  cd "$project_dir/site/web/app/themes/sage" || return
                elif [[ -d "$project_dir/site/htdocs/content/themes/themosis" ]]; then
                  cd "$project_dir/site/htdocs/content/themes/themosis" || return
                else
                  echo "Theme directory not found for $project_dir"
                  return
                fi
                ;;
              *)
                echo "Invalid second argument. Options are: site, trellis, theme."
                return
                ;;
            esac
          fi
        }
      '';
    };
  };
}
