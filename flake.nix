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
  in {
    nixosConfigurations = {
      work = nixpkgs.lib.nixosSystem {
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./hosts/work/configuration.nix
        ];
      };

      nextcloud = nixpkgs.lib.nixosSystem {
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./hosts/nextcloud/configuration.nix
        ];
      };

      kids = nixpkgs.lib.nixosSystem {
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./hosts/kids/configuration.nix
        ];
      };

      vm = nixpkgs.lib.nixosSystem {
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./hosts/vm/configuration.nix
        ];
      };
    };
  };
}