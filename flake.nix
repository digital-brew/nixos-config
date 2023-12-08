{
  description = "My Personal NixOS and Darwin System Flake Configuration";

  inputs = {
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-colors.url = "github:misterio77/nix-colors";

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    # only needed if you use as a package set:
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";

#    nix-shopify-cli.url = "https://flakehub.com/f/digital-brew/nix-shopify-cli/*.tar.gz";
    nix-shopify-cli.url = "github:digital-brew/nix-shopify-cli";
  };

  outputs = { self, nixpkgs, home-manager, nix-alien, nixpkgs-wayland, nix-shopify-cli, ... }@inputs:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;

    user = "moonlander";
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit system nixpkgs home-manager inputs nix-alien user nixpkgs-wayland nix-shopify-cli;
      }
    );
  };
}
