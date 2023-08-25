#
# Desktop video recorder
#

{config, nix, pkgs, ...}:

{
  programs.obs-studio = {
    enable = true;
  };
}