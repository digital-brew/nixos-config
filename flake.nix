{
  description = "My Personal NixOS and Darwin System Flake Configuration";

  inputs = {
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = { self, nixpkgs, home-manager, nix-alien, ... }:
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
        inherit system nixpkgs home-manager nix-alien user;
      }
    );
  };
}
