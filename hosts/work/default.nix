{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # Include Apple T2 patches
    "${builtins.fetchGit {
      url = "https://github.com/nixos/nixos-hardware.git";
      ref = "master";
      rev = "7f1836531b126cfcf584e7d7d71bf8758bb58969";
    }}/apple/t2"
    # Apple sound setting patch
    ../../modules/nixos/firmware/work/sound/pipewire_sink_conf.nix
    ./configuration.nix
  ];
}