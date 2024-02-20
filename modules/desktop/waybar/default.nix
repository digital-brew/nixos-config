# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: WAYBAR
# Type: Module (HomeManager)
# Location: /modules/desktop/waybar/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, inputs, system, pkgs, extraConfig, ... }:
let
  wayland = inputs.nixpkgs-wayland.packages.${system};
  username = extraConfig.mainUser.username;
  colorScheme = inputs.nix-colors.colorSchemes.${extraConfig.colorScheme};
in
{
  options.customModules.desktop.waybar = {
    enable = lib.mkEnableOption "Whether to enable the waybar, highly customizable wayland bar.";
  };

  config = lib.mkIf config.customModules.desktop.waybar.enable {
    home-manager.users.${username} = {
      home.packages = [
        wayland.waybar
      ];

      home.file."nixos-config/modules/desktop/waybar/dotfiles/colors.css".text = ''
        /**
          Color scheme name: Ayu Mirage
          Color scheme url: https://github.com/tinted-theming/base16-schemes/blob/main/ayu-mirage.yaml
        **/

        @define-color background #${colorScheme.palette.base01};
        /* @define-color backgroundAlpha #${colorScheme.palette.base01}80; */

        @define-color foreground #${colorScheme.palette.base07};
        /* @define-color foregroundAlpha #${colorScheme.palette.base07}80; */


        @define-color color00 #${colorScheme.palette.base00};
        /* @define-color color00Alpha #${colorScheme.palette.base00}80; */

        @define-color color01 #${colorScheme.palette.base01};
        /* @define-color color01Alpha #${colorScheme.palette.base01}80; */

        @define-color color02 #${colorScheme.palette.base02};
        /* @define-color color02Alpha #${colorScheme.palette.base02}80; */

        @define-color color03 #${colorScheme.palette.base03};
        /* @define-color color03Alpha #${colorScheme.palette.base03}80; */

        @define-color color04 #${colorScheme.palette.base04};
        /* @define-color color04Alpha #${colorScheme.palette.base04}80; */

        @define-color color05 #${colorScheme.palette.base05};
        /* @define-color color05Alpha #${colorScheme.palette.base05}80; */

        @define-color color06 #${colorScheme.palette.base06};
        /* @define-color color06Alpha #${colorScheme.palette.base06}80; */

        @define-color color07 #${colorScheme.palette.base07};
        /* @define-color color07Alpha #${colorScheme.palette.base07}80; */

        @define-color color08 #${colorScheme.palette.base08};
        /* @define-color color08Alpha #${colorScheme.palette.base08}80; */

        @define-color color09 #${colorScheme.palette.base09};
        /* @define-color color09Alpha #${colorScheme.palette.base09}80; */

        @define-color color0A #${colorScheme.palette.base0A};
        /* @define-color color0AAlpha #${colorScheme.palette.base0A}80; */

        @define-color color0B #${colorScheme.palette.base0B};
        /* @define-color color0BAlpha #${colorScheme.palette.base0B}80; */

        @define-color color0C #${colorScheme.palette.base0C};
        /* @define-color color0CAlpha #${colorScheme.palette.base0C}80; */

        @define-color color0D #${colorScheme.palette.base0D};
        /* @define-color color0DAlpha #${colorScheme.palette.base0D}80; */

        @define-color color0E #${colorScheme.palette.base0E};
        /* @define-color color0EAlpha #${colorScheme.palette.base0E}80; */

        @define-color color0F #${colorScheme.palette.base0F};
        /* @define-color color0FAlpha #${colorScheme.palette.base0F}80; */
      '';
    };
  };
}
