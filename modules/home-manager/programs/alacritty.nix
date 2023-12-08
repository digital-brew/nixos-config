#
# Terminal Emulator
#

{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
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
        normal = {
          family = "Hack Nerd Font Propo";
        };
      };
      colors = {
        primary = {
          background =  "#${config.colorScheme.colors.base01}"; #1E1E2E # base
          foreground = "#${config.colorScheme.colors.base07}"; #CDD6F4 # text
          # Bright and dim foreground colors
          dim_foreground = "#${config.colorScheme.colors.base04}"; #CDD6F4 # text
          bright_foreground = "#${config.colorScheme.colors.base05}"; #CDD6F4 # text
        };
        cursor = {
          text =  "#${config.colorScheme.colors.base01}";
          cursor = "#${config.colorScheme.colors.base0A}";
        };
        vi_mode_cursor = {
          text = "#${config.colorScheme.colors.base01}";
          cursor = "#${config.colorScheme.colors.base0D}";
        };
        search = {
          matches = {
            foreground = "#${config.colorScheme.colors.base01}";
            background = "#${config.colorScheme.colors.base0C}";
          };
          focused_match = {
            foreground = "#${config.colorScheme.colors.base01}";
            background = "#${config.colorScheme.colors.base0D}";
          };
          footer_bar = {
            foreground = "#${config.colorScheme.colors.base01}";
            background = "#${config.colorScheme.colors.base0E}";
          };
        };
        hints = {
          start = {
            foreground = "#${config.colorScheme.colors.base01}";
            background = "#${config.colorScheme.colors.base0A}";
          };
          end = {
            foreground = "#${config.colorScheme.colors.base01}";
            background = "#${config.colorScheme.colors.base0E}";
          };
        };
        selection = {
          text = "#${config.colorScheme.colors.base00}";
          background = "#${config.colorScheme.colors.base05}";
        };
        normal = {
          black = "#${config.colorScheme.colors.base04}"; #45475A # surface1
          red = "#${config.colorScheme.colors.base08}"; #F38BA8 # red
          green = "#${config.colorScheme.colors.base0B}"; #A6E3A1 # green
          yellow = "#${config.colorScheme.colors.base0A}"; #F9E2AF # yellow
          blue = "#${config.colorScheme.colors.base0D}"; #89B4FA # blue
          magenta = "#${config.colorScheme.colors.base09}"; #F5C2E7 # pink
          cyan = "#${config.colorScheme.colors.base0C}"; #94E2D5 # teal
          white = "#${config.colorScheme.colors.base07}"; #BAC2DE # subtext1
        };
        bright = {
          black = "#${config.colorScheme.colors.base04}"; #45475A # surface1
          red = "#${config.colorScheme.colors.base08}"; #F38BA8 # red
          green = "#${config.colorScheme.colors.base0B}"; #A6E3A1 # green
          yellow = "#${config.colorScheme.colors.base0A}"; #F9E2AF # yellow
          blue = "#${config.colorScheme.colors.base0D}"; #89B4FA # blue
          magenta = "#${config.colorScheme.colors.base09}"; #F5C2E7 # pink
          cyan = "#${config.colorScheme.colors.base0C}"; #94E2D5 # teal
          white = "#${config.colorScheme.colors.base07}"; #BAC2DE # subtext1
        };
        dim = {
          black = "#${config.colorScheme.colors.base04}"; #45475A # surface1
          red = "#${config.colorScheme.colors.base08}"; #F38BA8 # red
          green = "#${config.colorScheme.colors.base0B}"; #A6E3A1 # green
          yellow = "#${config.colorScheme.colors.base0A}"; #F9E2AF # yellow
          blue = "#${config.colorScheme.colors.base0D}"; #89B4FA # blue
          magenta = "#${config.colorScheme.colors.base09}"; #F5C2E7 # pink
          cyan = "#${config.colorScheme.colors.base0C}"; #94E2D5 # teal
          white = "#${config.colorScheme.colors.base07}"; #BAC2DE # subtext1
        };
      };
      shell = {
        program = "/etc/profiles/per-user/moonlander/bin/zsh";
      };
    };
  };
}