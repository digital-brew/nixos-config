{ pkgs, lib, nix-alien, ... }:

{
  imports = 
    [(import ./hardware-configuration.nix)] ++
    [(import ./configuration.nix)] ++
    [(import ./nextcloud.nix)];
}
