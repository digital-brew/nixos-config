{ lib, config, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./bootloader.nix
    ./fonts.nix
    ./keyboard.nix
    ./locale.nix
    ./networking.nix
    ./printer.nix
    ./services.nix
    ./sound.nix
    ./system.nix
    ./users.nix
  ];
}
