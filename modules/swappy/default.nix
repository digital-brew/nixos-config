# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: SWAPPY
# Type: Module (NixOS)
# Location: /modules/desktop/swappy/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, inputs, system, extraConfig, ... }:
let
  wayland = inputs.nixpkgs-wayland.packages.${system};
  username = extraConfig.mainUser.username;
  homeDir = extraConfig.mainUser.homeDir;
in
{
  options.customModules.swappy = {
    enable = lib.mkEnableOption "Whether to enable swappy, a wayland native snapshot editing tool, inspired by snappy on macos.";
  };

  config = lib.mkIf config.customModules.swappy.enable {
    environment.systemPackages = [
      pkgs.swappy
    ];

    home-manager.users.${username} = {
      home.packages = [
        wayland.waybar
      ];

      home.file.".config/swappy".text = ''
        [Default]
        save_dir=${homeDir}/Screenshots
        save_filename_format=screenshot_%Y%m%d_%H%M%S.png
        show_panel=true
        line_size=4
        text_size=20
        text_font=sans-serif
        paint_mode=brush
        early_exit=true
        fill_shape=false
      '';
    };
  };
}
