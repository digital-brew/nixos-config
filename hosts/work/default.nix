{ pkgs, lib, ... }:

{
  imports = 
  [(import ./hardware-configuration.nix)] ++
    # Include Apple T2 patches
    [(import "${builtins.fetchGit {
      url = "https://github.com/nixos/nixos-hardware.git";
      ref = "master";
      rev = "7f1836531b126cfcf584e7d7d71bf8758bb58969";
    }}/apple/t2")] ++
    # Apple sound setting patch
    [(import ../../modules/nixos/firmware/work/sound/pipewire_sink_conf.nix)] ++
    [(import ../../modules/nixos/desktop/gnome.nix)] ++
    # [(import ../../modules/nixos/themes/catppuccin.nix)] ++
#    [(import ../../modules/nixos/packages/nix-alien.nix)] ++
    [(import ./configuration.nix)] ++
    [(import ./hosts.nix)];
}
