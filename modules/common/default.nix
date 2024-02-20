# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: COMMON
# Type: Imports (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./bootloader
    ./disks.nix
    ./fonts.nix
    ./keyboard.nix
    ./locale.nix
    ./mime-types.nix
    ./networking
    ./printer.nix
    ./services.nix
    ./sound.nix
    ./system.nix
    ./theme.nix
    ./users.nix
  ];
}
