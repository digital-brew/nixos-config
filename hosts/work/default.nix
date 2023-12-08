{ pkgs, lib, nix-alien, ... }:

{
  imports = 
    [(import ./hardware-configuration.nix)] ++
    # Include Apple T2 patches
    [(import "${builtins.fetchGit {
      url = "https://github.com/nixos/nixos-hardware.git";
      ref = "master";
      rev = "2b00bc76dc893cd996a3d76a2f059d657a5ef37a"; # last: 11d50c5d52472ed40d3cb109daad03c836d2b328, 80d98a7d55c6e27954a166cb583a41325e9512d7, 32264b21bb23fbc00672b3ed6fcfaa5489d03991, c2bbfcfc3d12351919f8df7c7d6528f41751d0a3, 570256327eb6ca6f7bebe8d93af49459092a0c43, 7f1836531b126cfcf584e7d7d71bf8758bb58969
    }}/apple/t2")] ++
#    [(import "${builtins.fetchGit {
#      url = "https://github.com/digital-brew/nixos-hardware.git";
#      ref = "master";
#      rev = "1d324a481b29a6f11ff4affcbdb2f9cc8c30f40e"; # last: 11d50c5d52472ed40d3cb109daad03c836d2b328, 80d98a7d55c6e27954a166cb583a41325e9512d7, 32264b21bb23fbc00672b3ed6fcfaa5489d03991, c2bbfcfc3d12351919f8df7c7d6528f41751d0a3, 570256327eb6ca6f7bebe8d93af49459092a0c43, 7f1836531b126cfcf584e7d7d71bf8758bb58969
#    }}/apple/t2")] ++
    # Apple sound setting patch
    [(import ../../modules/nixos/firmware/work/sound/pipewire_sink_conf.nix)] ++
    # Other modules
    [(import ../../modules/nixos/desktop/xfce.nix)] ++
    [(import ../../modules/nixos/services/qemu.nix)] ++
    [(import ../../modules/nixos/services/samba.nix)] ++
    [(import ../../modules/nixos/services/flatpak.nix)] ++
    # Patch for Dell dock
    [(import ../../modules/nixos/patches/dell-d6000-ethernet/patch.nix)] ++
    # Configuration files
    [(import ./overlays.nix)] ++
    [(import ./configuration.nix)] ++
    [(import ./hosts.nix)];
}
