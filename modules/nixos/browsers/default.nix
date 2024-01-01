{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.browsers = {
    enable = mkEnableOption "browsers service";
  };

  config = mkIf config.modules.browsers.enable {
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