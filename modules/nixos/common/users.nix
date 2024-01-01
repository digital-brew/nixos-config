{ lib, config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.moonlander = {
    isNormalUser = true;
    description = "moonlander";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix.settings.trusted-users = ["root" "moonlander"];
}
