{ lib, inputs, nixpkgs, home-manager, user, ... }:

let
  system = "x86_64-linux";                                  # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{

  work = lib.nixosSystem {                                # Laptop profile
    inherit system;
    specialArgs = {
      inherit system inputs user;
    };
    modules = [
      ./common
      ./work

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
        };
        home-manager.users.${user}  = {
          imports = [(import ./common/home.nix)] ++ [(import ./work/home.nix)];
        };
      }
    ];
  };

  nextcloud = lib.nixosSystem {                                  # Work profile
    inherit system;
    specialArgs = {
      inherit system inputs user;
      host = {
        hostName = "DBNC3G";
      };
    };
    modules = [
      ./common
      ./nextcloud

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
          host = {
            hostName = "DBNC3G";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./common/home.nix)] ++ [(import ./nextcloud/home.nix)];
        };
      }
    ];
  };

  vm = lib.nixosSystem {                                    # VM profile
    inherit system;
    specialArgs = {
      inherit inputs user;
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
      inherit inputs user;
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