{ lib, config, pkgs, ... }:
  with lib;
{
  options.services.browsers = {
    enable = mkEnableOption "browsers service";
  };

  config = mkIf config.services.browsers.enable {
    environment.systemPackages = with pkgs; [
      brave
      epiphany
      google-chrome
      librewolf
    ];

    programs = {
      chromium.enable = true;
      firefox.enable = true;
    };
  };
}