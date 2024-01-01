{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.communication = {
    enable = mkEnableOption "communication service";
  };

  config = mkIf config.modules.communication.enable {
    environment.systemPackages = with pkgs; [
      discord                                   # All-in-one cross-platform voice and text chat for gamers
      signal-desktop                            # Private, simple, and secure messenger
    ];

    programs = {
     
    };
  };
}