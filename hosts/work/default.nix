{ pkgs, lib, nix-alien, ... }:

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
    [(import ../../modules/nixos/desktop/xfce.nix)] ++
    [(import ../../modules/nixos/services/qemu.nix)] ++
    [(import ../../modules/nixos/services/samba.nix)] ++
    [(import ./configuration.nix)] ++
    [(import ./overlays.nix)] ++
    [(import ./hosts.nix)];
}
