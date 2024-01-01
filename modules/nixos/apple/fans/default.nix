{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.apple.fans = {
    enable = mkEnableOption "apple fans service";
  };

  config = mkIf config.modules.apple.fans.enable {
    # Create a t2fand config file in /etc
    environment.etc."t2fand.conf".text = ''
      [Fan1]
      low_temp = 55
      high_temp = 75
      speed_curve = linear
      always_full_speed = false

      [Fan2]
      low_temp = 55
      high_temp = 75
      speed_curve = linear
      always_full_speed = false
    '';

    # Spin up t2fand service
    systemd.services.t2fand = {
      enable = true;
      description = "A simple daemon to control fan speed on Macs with T2 chip";
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        Restart = "always";
        RestartSec = 2;
        ExecStart = "/run/current-common/sw/bin/python3 /run/current-common/sw/bin/t2fand";
      };
      wantedBy = [ "default.target" ];
    };
  };
}
