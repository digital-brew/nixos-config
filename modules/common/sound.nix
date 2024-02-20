# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: SOUND (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  # Enable sound with pipewire.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  systemd.user.services.pipewire.environment = {
    LADSPA_PATH = "${pkgs.ladspaPlugins}/lib/ladspa";
    LV2_PATH = "${config.system.path}/lib/lv2";
  };

  environment.systemPackages = with pkgs; [
#    calf                                      # A set of high quality open source audio plugins for musicians
#    ladspaPlugins                             # LADSPA format audio plugins
#    lsp-plugins                               # Collection of open-source audio plugins
    pavucontrol                               # PulseAudio Volume Control
    pipewire                                  # Server and user space API to deal with multimedia pipelines
    pulseaudio                                # Sound server for POSIX common
    pw-volume                                 # Basic interface to PipeWire volume controls
    wireplumber                               # A modular session / policy manager for PipeWire
  ];
}
