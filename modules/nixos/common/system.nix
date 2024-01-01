{ lib, config, pkgs, ... }:

{
  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Workaround for https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = _: true;

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
  system.stateVersion = "23.11"; # Did you read the comment?
}
