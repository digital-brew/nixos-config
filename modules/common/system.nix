# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: SYSTEM (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, pkgs, hostname, ... }:

{
  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  nix.settings.auto-optimise-store = true;

#  nix.package = pkgs.nixFlakes;

  # Workaround for https://github.com/nix-community/home-manager/issues/2942
  # nixpkgs.config.allowUnfreePredicate = _: true;

  # Enabe nix extra options
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your common were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this common.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
#  lib.config = [
#    (lib.mkIf (hostName == "vm") {
#      system.stateVersion = "23.11";
#    })
#
#    (lib.mkIf (hostName == "work") {
#      system.stateVersion = "23.05";
#    })
#  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  system.stateVersion = "23.05";
}
