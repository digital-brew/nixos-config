# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: TERMINAL: ALACRITTY
# Type: Module (HomeManager)
# Location: /modules/terminal/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, inputs, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
  colorScheme = inputs.nix-colors.colorSchemes.${extraConfig.colorScheme};
in
{
  config = lib.mkIf config.customModules.terminal.enable {
    home-manager.users.${username} = {
      programs.alacritty = {
        enable = true;
      };

      programs.alacritty.settings = {
        window = {
          title = "Alacritty";
          class = {
            instance = "Alacritty";
            general = "Alacritty";
          };
          padding = {
            x =  20;
            y = 12;
          };
        };
        font = {
          size = 12;
          offset = {
            x = 0;
            y = 3;
          };
  #        normal = {
  #          family = "Hack Nerd Font Propo";
  #        };
        };
        colors = {
          primary = {
            background = "#${colorScheme.palette.base01}"; #1E1E2E # base
            foreground = "#${colorScheme.palette.base07}"; #CDD6F4 # text
            # Bright and dim foreground colors
            dim_foreground = "#${colorScheme.palette.base04}"; #CDD6F4 # text
            bright_foreground = "#${colorScheme.palette.base05}"; #CDD6F4 # text
          };
          cursor = {
            text = "#${colorScheme.palette.base01}";
            cursor = "#${colorScheme.palette.base0A}";
          };
          vi_mode_cursor = {
            text = "#${colorScheme.palette.base01}";
            cursor = "#${colorScheme.palette.base0D}";
          };
          search = {
            matches = {
              foreground = "#${colorScheme.palette.base01}";
              background = "#${colorScheme.palette.base0C}";
            };
            focused_match = {
              foreground = "#${colorScheme.palette.base01}";
              background = "#${colorScheme.palette.base0D}";
            };
          };
          hints = {
            start = {
              foreground = "#${colorScheme.palette.base01}";
              background = "#${colorScheme.palette.base0A}";
            };
            end = {
              foreground = "#${colorScheme.palette.base01}";
              background = "#${colorScheme.palette.base0E}";
            };
          };
          selection = {
            text = "#${colorScheme.palette.base00}";
            background = "#${colorScheme.palette.base05}";
          };
          normal = {
            black = "#${colorScheme.palette.base04}"; #45475A # surface1
            red = "#${colorScheme.palette.base08}"; #F38BA8 # red
            green = "#${colorScheme.palette.base0B}"; #A6E3A1 # green
            yellow = "#${colorScheme.palette.base0A}"; #F9E2AF # yellow
            blue = "#${colorScheme.palette.base0D}"; #89B4FA # blue
            magenta = "#${colorScheme.palette.base09}"; #F5C2E7 # pink
            cyan = "#${colorScheme.palette.base0C}"; #94E2D5 # teal
            white = "#${colorScheme.palette.base07}"; #BAC2DE # subtext1
          };
          bright = {
            black = "#${colorScheme.palette.base04}"; #45475A # surface1
            red = "#${colorScheme.palette.base08}"; #F38BA8 # red
            green = "#${colorScheme.palette.base0B}"; #A6E3A1 # green
            yellow = "#${colorScheme.palette.base0A}"; #F9E2AF # yellow
            blue = "#${colorScheme.palette.base0D}"; #89B4FA # blue
            magenta = "#${colorScheme.palette.base09}"; #F5C2E7 # pink
            cyan = "#${colorScheme.palette.base0C}"; #94E2D5 # teal
            white = "#${colorScheme.palette.base07}"; #BAC2DE # subtext1
          };
          dim = {
            black = "#${colorScheme.palette.base04}"; #45475A # surface1
            red = "#${colorScheme.palette.base08}"; #F38BA8 # red
            green = "#${colorScheme.palette.base0B}"; #A6E3A1 # green
            yellow = "#${colorScheme.palette.base0A}"; #F9E2AF # yellow
            blue = "#${colorScheme.palette.base0D}"; #89B4FA # blue
            magenta = "#${colorScheme.palette.base09}"; #F5C2E7 # pink
            cyan = "#${colorScheme.palette.base0C}"; #94E2D5 # teal
            white = "#${colorScheme.palette.base07}"; #BAC2DE # subtext1
          };
        };
        shell = {
          program = "/home/moonlander/.nix-profile/bin/zsh";
        };
      };
    };
  };
}
