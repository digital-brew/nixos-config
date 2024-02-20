{
  description = "Nixos config flake";

  inputs = {
    # latest: c3e9c0b5f8242f8d2a52136f58ec663c4d5d4b26 (2024-02-02) - release-23.11
    # current: b8b232ae7b8b144397fdb12d20f592e5e7c1a64d (2024-01-31) - nixos-u
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # current: cc65e27670abccced5997d4a93c4c930aef6fd0b (2024-02-01)
#    nixos-hardware.url = "github:NixOS/nixos-hardware/cc65e27670abccced5997d4a93c4c930aef6fd0b";
    nixos-hardware.url = "github:digital-brew/nixos-hardware/52346b8668bef3411aa2c098426f6fb56043eb75"; # Latest: f6f9cda2cf01902243889566f16995bb2c603033

    # current: 10cd9c53115061aa6a0a90aad0b0dde6a999cdb9 (2024-01-19) - release-23.11
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-colors.url = "github:misterio77/nix-colors";

    hyprland.url = "github:hyprwm/hyprland";
#    xremap-flake.url = "github:xremap/nix-flake";

    nix-shopify-cli.url = "github:digital-brew/nix-shopify-cli";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    phps.url = "github:fossar/nix-phps";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    extraConfig = {
      mainUser = {
        username = "moonlander";
        homeDir = "/home/moonlander";
      };
      configDir = "/home/moonlander/nixos-config";
      colorScheme = "ayu-mirage";
      terminal = "alacritty";
      editor = "phpstorm";
    };
  in
  {
    config = {
      nix.settings = {
        # wayland binary caches
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        ];
        substituters = [
          "https://cache.nixos.org"
          "https://nixpkgs-wayland.cachix.org"
        ];
      };
    };

    # Host: MediaCenter
#    nixosConfigurations.mediacenter = nixpkgs.lib.nixosSystem {
#      specialArgs = {
#        machineName = "mediacenter";
#        inherit system inputs extraConfig;
#      };
#      modules = [ ./hosts/mediacenter/configuration.nix ];
#    };

    # Host: Nextcloud
#    nixosConfigurations.nextcloud = nixpkgs.lib.nixosSystem {
#      specialArgs = {
#        machineName = "nextcloud";
#        inherit system inputs extraConfig;
#      };
#      modules = [ ./hosts/nextcloud/configuration.nix ];
#    };

    # Host: VirtualMachine
#    nixosConfigurations.virtualmachine = nixpkgs.lib.nixosSystem {
#      specialArgs = {
#        machineName = "virtualmachine";
#        inherit system inputs extraConfig;
#      };
#      modules = [ ./hosts/virtualmachine/configuration.nix ];
#    };

    # Host: Work
    nixosConfigurations.work = nixpkgs.lib.nixosSystem {
      specialArgs = {
        machineName = "work";
        inherit system inputs extraConfig;
      };
      modules = [ ./hosts/work/configuration.nix ];
    };
  };
}
