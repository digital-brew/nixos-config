{ lib, config, pkgs, ... }:
  with lib;
{
  options.browsers = {
    enable = mkEnableOption "browsers service";
  };

  config = mkIf config.browsers.enable {
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