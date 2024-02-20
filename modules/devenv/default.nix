# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: DEVENV
# Type: Module (NixOS)
# Location: /modules/devenv/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, system, inputs, ... } @ args:
let
  pythonDeps = ps: with ps; [
    ansible
    ansible-core
    cryptography
    jinja2
    markupsafe
    packaging
    pandas
    passlib
    pillow
    pip
    pyyaml
    requests
    resolvelib
    virtualenv
  ];
#  nixpkgs = inputs.nixpkgs;
  shopify-cli = inputs.nix-shopify-cli.packages.${system}.default;
  devenv = inputs.devenv.packages.${system}.default;
  phps = inputs.phps.packages.${system}.php;
in
{
  options.customModules.devenv = {
    enable = lib.mkEnableOption "Whether to enable all programs and services for development.";
  };

  config = lib.mkIf config.customModules.devenv.enable {
    environment.systemPackages = [
      # Apps
      pkgs.beekeeper-studio                           # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more
      pkgs.cachix                                     # Command-line client for Nix binary cache hosting https://cachix.org
      pkgs.colordiff                                  # Wrapper for 'diff' that produces the same output but with pretty 'syntax' highlighting
      pkgs.dbeaver                                    # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
      pkgs.diffuse                                    # Graphical tool for merging and comparing text files
      pkgs.jetbrains.pycharm-community                # Free Python IDE from JetBrains
      pkgs.kdiff3                                     # Compares and merges 2 or 3 files or directories
      pkgs.ngrok                                      # Allows you to expose a web server running on your local machine to the internet
      pkgs.poedit                                     # Gettext catalogs (.po files) editor
      pkgs.ruby                                       # An object-oriented language for quick and easy programming
      pkgs.tkdiff                                     # A graphical front end to the diff program
      pkgs.yarn                                       # Fast, reliable, and secure dependency management for javascript
      pkgs.vscode                                     # Open source source code editor developed by Microsoft

      # PHPStorm with overlay
      pkgs.phpstorm                                   # PHP IDE from JetBrains

      # Python 3
      (pkgs.python3.withPackages pythonDeps)          # python 3 with extensions

      # POEdit deps
      pkgs.aspell                                     # Spell checker for many languages
      pkgs.aspellDicts.pl                             # Aspell dictionary for Polish
      pkgs.aspellDicts.en                             # Aspell dictionary for English

      shopify-cli
      devenv
      phps
    ];

#    devShell.x86_64-linux = nixpkgs.legacyPackages.${system}.mkShell {
#      buildInputs = [
#        phps.packages.${system}.php
#      ];
#    };
  };
}
