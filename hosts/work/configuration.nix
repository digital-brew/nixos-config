{ config, pkgs, lib, ... }:
let
  python-pkgs = ps: with ps; [
    pandas
    requests
    pip
    pillow
  ];
in
{
  imports = [
    import ../../modules/nixos/packages/nix-alien.nix
  ];
  # Systemd-boot EFI boot loader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };
  };

  # Hostname
  networking = {
    hostName = "DBi9XRL";
    # hosts = {
    #   "127.0.0.1" = [
    #     "local.stratus.earth"
    #     "local.nades.com"
    #     ];
    # };
    networkmanager = {
      enable = true;
      wifi = {
        scanRandMacAddress = false;
      };
    };
    useDHCP = lib.mkDefault false;
#    interfaces.enp9s0u2u1i5 = {
#      useDHCP = lib.mkDefault true;
#    };
#    interfaces.wlan0 = {
#      useDHCP = lib.mkDefault true;
#    };
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 4040 2019 ];
      allowedUDPPorts = [ 22 80 443 4040 2019 ];
    };
  };

  # Needed for Dell D6000 dockind station
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable for Mailspring
  services.gnome.gnome-keyring.enable = true;

  # Enable sound
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.alsa.enable = true;
  hardware.pulseaudio.enable = false;
  systemd.user.services.pipewire.environment = {
    LADSPA_PATH = "${pkgs.ladspaPlugins}/lib/ladspa";
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs;
    let
      sddm-theme-sugar-dark = pkgs.callPackage ../../modules/nixos/themes/sddm-sugar-dark.nix {};
      sddm-theme-sugar-candy = pkgs.callPackage ../../modules/nixos/themes/sddm-sugar-candy.nix {};
    in [
      sddm-theme-sugar-dark.default                           # sddm theme
      sddm-theme-sugar-candy.default                          # sddm theme
      libsForQt5.sddm-kcm                        # sddm theme installer
      libsForQt5.kdeconnect-kde
      libsForQt5.gwenview
      libsForQt5.plasma-thunderbolt              # plasma integration for controlling Thunderbolt devicesx
      xclip                                      # command line interface to X selections (clipboard)
      xsel                                       # manipulate the X selection
      # firefox                                    # browser
      xfce.thunar                                # xfce file manager
      xfce.thunar-volman                         # Thunar extension for automatic management of removable drives and media
      xfce.thunar-dropbox-plugin                 # A plugin that adds context-menu items for Dropbox to Thunar
      xfce.thunar-archive-plugin                 # Thunar plugin providing file context menus for archives
      xfce.thunar-media-tags-plugin              # Thunar plugin providing tagging and renaming features for media files
      dolphin                                    # kde file manager
      direnv                                     # shell extension that manages your environment
#     .feh                                        # image viewer
      ngrok                                      # expose a web server running on your local machine to the internet
      neofetch                                   # system info script
      libnotify                                  # a library that sends desktop notifications to a notification daemon
#     .flameshot                                  # screenshot software
      cachix                                     # cli client for Nix binary cache hostin
      lxappearance                               # configuring the theme and fonts of gtk apps
      xarchiver                                  # frontend to 7z, zip, rar, tar, bzip2, gzip, arj, lha, rpm and deb
      jetbrains.phpstorm                         # professional IDE for Web and PHP developers
      jetbrains.pycharm-community
      poedit
      postman
      figma-linux
      vlc
      libreoffice
      # qmk
      spotifyd
      xkeysnail
#        alsa-utils
      yubioath-flutter
#        virtualboxWithExtpack
#        ansible_2_14
      handbrake                                  # A tool for converting video files and ripping DVDs
      sddm-chili-theme                           # sddm theme
#        thunderbolt                                # thunderbolt(TM) user-space components
#        betterbird
      pciutils                                   # collection of programs for inspecting and manipulating configuration of PCI devices
      (python3.withPackages python-pkgs)  # python 3 with extensions
      maia-icon-theme
      rhythmbox
      playerctl
      pw-volume
      xdotool
      google-fonts
      # swappy
      # swaylock
      # wl-clipboard
      # wlr-randr
      # wofi
      krita
      inkscape
      blender
      gimp
      darktable
      libsForQt5.kdenlive
      davinci-resolve
      pro-office-calculator
      # vscode
      libsecret
      gnome.gnome-calendar
      pika-backup
      # Audio
      ladspaPlugins
      lsp-plugins
      pipewire
      wireplumber
#      (import (fetchTarball https://install.devenv.sh/latest)).default # devenv
#      (import (fetchTarball {
#        url = "https://github.com/thiagokokada/nix-alien/tarball/master";
#        sha256 = "1q1l0jzrq6ssc21ra6gvj5k01qn49cmd3403g0j05jvqhfkvs4z0";
#      })).nix-alien
    ];
  };
}
