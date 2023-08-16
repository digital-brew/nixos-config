{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, nur, user, location, hyprland, plasma-manager, ... }:

let
  system = "x86_64-linux";                                  # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{

  work = lib.nixosSystem {                                # Laptop profile
    inherit system;
    specialArgs = {
      inherit unstable inputs user location;
      host = {
        hostName = "DBi9XRL";
        laptopMonitor = "eDP-1";
        leftMonitor = "";
        centerMonitor = "";
        rightMonitor = "";
      };
    };
    modules = [
      ./work
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit unstable user;
          host = {
            hostName = "DBi9XRL";
            laptopMonitor = "eDP-1";
            leftMonitor = "";
            centerMonitor = "";
            rightMonitor = "";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./work/home.nix)];
        };
      }
    ];
  };

  nextcloud = lib.nixosSystem {                                  # Work profile
    inherit system;
    specialArgs = {
      inherit unstable system inputs user location hyprland;
      host = {
        hostName = "DBNC3G";
      };
    };
    modules = [
      ./nextcloud
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit unstable user;
          host = {
            hostName = "DBNC3G";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./nextcloud/home.nix)];
        };
      }
    ];
  };

  vm = lib.nixosSystem {                                    # VM profile
    inherit system;
    specialArgs = {
      inherit unstable inputs user location;
      host = {
        hostName = "DBVM";
        mainMonitor = "Virtual-1";
      };
    };
    modules = [
      ./vm
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit unstable user;
          host = {
            hostName = "DBVM";
            mainMonitor = "Virtual-1";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./vm/home.nix)];
        };
      }
    ];
  };

  kids = lib.nixosSystem {                                # Laptop profile
    inherit system;
    specialArgs = {
      inherit unstable inputs user location;
      host = {
        hostName = "DBi9XRL";
        laptopMonitor = "eDP-1";
      };
    };
    modules = [
      ./kids
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit unstable user;
          host = {
            hostName = "DB15MBP";
            laptopMonitor = "eDP-1";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./kids/home.nix)];
        };
      }
    ];
  };
}