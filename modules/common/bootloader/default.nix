# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: BOOTLOADER (COMMON)
# Type: Imports (NixOS)
# Location: /modules/common/bootloader/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  imports = [
    ./mediacenter.nix
    ./nextcloud.nix
    ./virtualmachine.nix
    ./work.nix
  ];
}
