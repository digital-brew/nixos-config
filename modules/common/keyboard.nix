# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: KEYBOARD (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  # Configure console keymap
  console.keyMap = "pl";

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
}
