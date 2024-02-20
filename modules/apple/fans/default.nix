# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: APPLE T2 FANS
# Type: Module (NixOS)
# Location: /modules/apple/fans/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.apple.fans = {
    enable = lib.mkEnableOption "Whether to enable service to handle the speed of Apple's T2 fans.";
  };

  config = lib.mkIf config.customModules.apple.fans.enable {
    systemd.services.t2fanrd = {
      enable = true;
      description = "T2FanRD daemon to manage fan curves for t2 macs";
      serviceConfig = {
        Type = "exec";
        Restart = "always";
        ExecStart = "/run/current-system/sw/bin/t2fanrd";
        PrivateTmp = "true";
        ProtectSystem = "true";
        ProtectHome = "true";
        ProtectClock = "true";
        ProtectHostname = "true";
        ProtectControlGroups = "true";
        ProtectKernelLogs = "true";
        ProtectKernelModules = "true";
        ProtectProc = "invisible";
        PrivateDevices = "true";
        PrivateNetwork = "true";
        NoNewPrivileges = "true";
        DevicePolicy = "closed";
        KeyringMode = "private";
        LockPersonality = "true";
        MemoryDenyWriteExecute = "true";
        PrivateUsers = "yes";
        RemoveIPC = "yes";
        RestrictNamespaces = "yes";
        RestrictRealtime = "yes";
        RestrictSUIDSGID = "yes";
        SystemCallArchitectures = "native";
      };
      wantedBy = [ "multi-user.target" ];
    };

#    systemd.services.t2fanrd = {
#      enable = true;
#      description = "A simple daemon to control fan speed on Macs with T2 chip";
#      unitConfig = {
#        Type = "simple";
#      };
#      serviceConfig = {
#        Restart = "always";
#        RestartSec = 2;
#        ExecStart = "/run/current-system/sw/bin/t2fanrd";
#        PIDFile = "/run/t2fanrd.pid";
#      };
#      wantedBy = [ "default.target" ];
#    };

    # Create a t2fand config file in /etc
    environment.etc."t2fand.conf".text = ''
      [Fan1]
      low_temp = 56
      high_temp = 75
      speed_curve = linear
      always_full_speed = false

      [Fan2]
      low_temp = 56
      high_temp = 75
      speed_curve = linear
      always_full_speed = false
    '';

#    environment.etc."/udev/rules.d/30-amdgpu-pm.rules".text = ''
#      KERNEL=="card1", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="low"
#    '';
  };
}
