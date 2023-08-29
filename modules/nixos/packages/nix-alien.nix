{ config, pkgs, lib, ... }:

let
  nix-alien-pkgs = import (
    fetchTarball {
      url = "https://github.com/thiagokokada/nix-alien/tarball/master";
      sha256 = "1q1l0jzrq6ssc21ra6gvj5k01qn49cmd3403g0j05jvqhfkvs4z0";
    }
  ) { };
in
{
  environment.systemPackages = with nix-alien-pkgs; [
    nix-alien
  ];

  # Optional, but this is needed for `nix-alien-ld` command
  programs.nix-ld.enable = true;
}