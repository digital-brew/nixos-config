{ lib, config, pkgs, ... }:
  with lib;
{
  options.modules.sound = {
    enable = mkEnableOption "sound service";
  };

  config = mkIf config.modules.sound.enable {

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      ladspaPlugins                             # LADSPA format audio plugins
      lsp-plugins                               # Collection of open-source audio plugins
      pavucontrol                               # PulseAudio Volume Control
      pipewire                                  # Server and user space API to deal with multimedia pipelines
      pulseaudio                                # Sound server for POSIX common
      pw-volume                                 # Basic interface to PipeWire volume controls
      wireplumber                               # A modular session / policy manager for PipeWire
    ];
  };
}
