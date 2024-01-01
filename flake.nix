{
  description = "My Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "github:hyprwm/hyprland";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    # only needed if you use as a package set:
#    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    nix-shopify-cli.url = "github:digital-brew/nix-shopify-cli";
    phps.url = "github:fossar/nix-phps";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    main-user = {
      username = "moonlander";
      home-dir = "/home/moonlander";
    };
    my-config = {
      location = "$HOME/nixos-config";
    };
  in {
    nixosConfigurations = {
      work = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/work/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };

      nextcloud = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nextcloud/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };

      kids = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/kids/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };

      vm = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs main-user;};
        modules = [
          ./hosts/vm/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
