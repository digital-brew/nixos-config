{ lib, config, pkgs, ... }:
let
  pythonDeps = ps: with ps; [
    pandas
    requests
    pip
    pillow
    passlib
    resolvelib
    pyyaml
    packaging
    markupsafe
    jinja2
    cryptography
    ansible-core
    ansible
    virtualenv
  ];
in
with lib;
{
  options.modules.devenv = {
    enable = mkEnableOption "devenv service";
  };

  config = mkIf config.modules.devenv.enable {
    environment.systemPackages = with pkgs; [
      # Apps
      beekeeper-studio                          # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more
      cachix                                    # Command-line client for Nix binary cache hosting https://cachix.org
      dbeaver                                   # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
      diffuse                                   # Graphical tool for merging and comparing text files
      jetbrains.pycharm-community-bin           # Free Python IDE from JetBrains
      kdiff3                                    # Compares and merges 2 or 3 files or directories
      ngrok                                     # Allows you to expose a web server running on your local machine to the internet
      phpstorm                                  # PHP IDE from JetBrains
      poedit                                    # Gettext catalogs (.po files) editor
      tkdiff                                    # A graphical front end to the diff program

      # Python 3
      (pkgs.python310.withPackages pythonDeps) # python 3 with extensions

      # POEdit deps
      aspell                                    # Spell checker for many languages
      aspellDicts.pl                            # Aspell dictionary for Polish
      aspellDicts.en                            # Aspell dictionary for English
    ];
  };
}