# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: NETWORKING (COMMON)
# Type: Imports (NixOS)
# Location: /modules/common/networking/
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
