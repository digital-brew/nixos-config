#!/usr/bin/env bash

ln -sfn /home/moonlander/nixos-config/modules/nixos/hyprland/dotfiles /home/moonlander/.config/hypr
chown -h moonlander:users /home/moonlander/.config/hypr

ln -sfn /home/moonlander/nixos-config/scripts /home/moonlander/.config/scripts
chown -h moonlander:users /home/moonlander/.config/scripts

ln -sfn /home/moonlander/nixos-config/modules/nixos/desktop/wayland/dotfiles/swappy /home/moonlander/.config/swappy
chown -h moonlander:users /home/moonlander/.config/swappy

ln -sfn /home/moonlander/nixos-config/modules/home-manager/waybar/dotfiles /home/moonlander/.config/waybar
chown -h moonlander:users /home/moonlander/.config/waybar

ln -sfn /home/moonlander/nixos-config/modules/nixos/symlinks/dotfiles/node/npmrc /home/moonlander/.npmrc
chown -h moonlander:users /home/moonlander/.npmrc