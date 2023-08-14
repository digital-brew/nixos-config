{ lib, pkgs, system, home-manager, ... }:
let

in
{
  macbook16 = lib.nixosSystem {
    inherit system;

    modules = [
      ./macbook16/hardware-configuration.nix
      # Include Apple T2 patches
      "${builtins.fetchGit {
        url = "https://github.com/nixos/nixos-hardware.git";
        ref = "master";
        rev = "24f9162b26f0debd163f6d94752aa2acb9db395a";
      }}/apple/t2"
      ./configuration.nix
      ./virtualisation.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.moonlander = {
          imports = [
            ./macbook16/home.nix
          ];

          home.stateVersion = "23.05";
        };
      }
    ];
  };
}