{ lib, nixpkgs, home-manager, inputs, nix-alien, nixpkgs-wayland, user, nix-shopify-cli, ... }:

let
  system = "x86_64-linux";                                  # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{

  work = lib.nixosSystem {                                  # Work profile
    inherit system;
    specialArgs = {
      inherit system user nix-shopify-cli;
    };
    modules = [
      ./common
      ./work
      ({ self, system, nix-shopify-cli, ... }: {
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

        environment.systemPackages = [
          nix-alien.packages.${system}.nix-alien
          nixpkgs-wayland.packages.${system}.grim
          nixpkgs-wayland.packages.${system}.slurp
          nixpkgs-wayland.packages.${system}.swww
          nixpkgs-wayland.packages.${system}.waybar
          nixpkgs-wayland.packages.${system}.wf-recorder
          nixpkgs-wayland.packages.${system}.wl-clipboard
          nixpkgs-wayland.packages.${system}.wlroots
          nix-shopify-cli.packages.${system}.default
        ];
      })

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
        };
        home-manager.users.${user}  = {
          imports = [
          (import ./common/home.nix)] ++
          [(import ./work/home.nix)] ++
          [inputs.nix-colors.homeManagerModules.default];

           colorScheme = inputs.nix-colors.colorSchemes.ayu-mirage;
        };
      }
    ];
  };

  nextcloud = lib.nixosSystem {                                  # Nextcloud profile
    inherit system;
    specialArgs = {
      inherit system user;
    };
    modules = [
      ./nextcloud

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
        };
        home-manager.users.moonlander = {
          imports = [(import ./nextcloud/home.nix)];
        };
      }
    ];
  };

  vm = lib.nixosSystem {                                    # VM profile
    inherit system;
    specialArgs = {
      inherit user;
      host = {
        hostName = "DBVM";
        mainMonitor = "Virtual-1";
      };
    };
    modules = [
      ./common
      ./vm

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
          host = {
            hostName = "DBVM";
            mainMonitor = "Virtual-1";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./common/home.nix)] ++ [(import ./vm/home.nix)];
        };
      }
    ];
  };

  kids = lib.nixosSystem {                                # Laptop profile
    inherit system;
    specialArgs = {
      inherit user;
      host = {
        hostName = "DBi9XRL";
        laptopMonitor = "eDP-1";
      };
    };
    modules = [
      ./common
      ./kids

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
          host = {
            hostName = "DB15MBP";
            laptopMonitor = "eDP-1";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./common/home.nix)] ++ [(import ./kids/home.nix)];
        };
      }
    ];
  };
}