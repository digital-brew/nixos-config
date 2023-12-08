{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # only needed if you use as a package set:
#    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-wayland }: {
    nixosConfigurations."my-laptop-hostname" =
    let system = "x86_64-linux";
    in nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [({pkgs, config, ... }: {
        config = {
          nix.settings = {
            # add binary caches
            trusted-public-keys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
            ];
            substituters = [
              "https://cache.nixos.org"
              "https://nixpkgs-wayland.cachix.org"
            ];
          };

          # use it as an overlay
#          nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];

          # or, pull specific packages (built against inputs.nixpkgs, usually `nixos-unstable`)
          environment.systemPackages = [
            nixpkgs-wayland.packages.${system}.waybar
          ];
        };
      })];
    };
  };
}