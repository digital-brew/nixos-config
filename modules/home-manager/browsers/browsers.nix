{ lib, config, pkgs, ... }:

{
  options.browsers = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf (config.browsers.enable) 
  {
    users.users.moonlander = {
      packages = with pkgs; [
        brave
        epiphany
        google-chrome
        librewolf
      ];

      chromium.enable = true;
      firefox.enable = true;
    };
  };
}