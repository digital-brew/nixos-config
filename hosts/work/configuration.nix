{ pkgs, lib, inputs, ... }:
{
  imports =
    # Hardware configuration
    [(import ./hardware-configuration.nix)] ++
    # Include Apple T2 patches
    [(import "${builtins.fetchGit {
      url = "https://github.com/digital-brew/nixos-hardware.git";
      ref = "master";
      rev = "5492aee64bd0ed99d90e2added93acd14d9ef8da"; # last: 1d324a481b29a6f11ff4affcbdb2f9cc8c30f40e
    }}/apple/t2")] ++
    # Apple sound setting patch
    [(import ./pipewire_sink_conf.nix)] ++
    [(import inputs.home-manager.nixosModules.default)];

    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      users = {
        "moonlander" = import ./home.nix;
      };
    };

    nix.settings = {
      trusted-users = ["root" "moonlander"];
      auto-optimise-store = true;
    };

    nix.package = pkgs.nixFlakes;

    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';

    system.stateVersion = "23.05";
}