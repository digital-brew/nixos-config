{ config, pkgs, lib, nix-alien, ... }:
let
  python-pkgs = ps: with ps; [
    pandas
    requests
    pip
    pillow
  ];
in
{
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
    networkmanager = {
      enable = true;
      wifi = {
        scanRandMacAddress = false;
      };
    };
    useDHCP = lib.mkDefault false;
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
    systemPackages =
    let
      sddm-theme-sugar-dark = pkgs.callPackage ../../modules/nixos/themes/sddm-sugar-dark.nix {};
      sddm-theme-sugar-candy = pkgs.callPackage ../../modules/nixos/themes/sddm-sugar-candy.nix {};
      trellis-cli = pkgs.callPackage ../../modules/nixos/packages/trellis-cli.nix {};
      browserstack = pkgs.callPackage ../../modules/nixos/packages/browserstack.nix {};
    in [
      sddm-theme-sugar-dark.default                           # sddm theme
      sddm-theme-sugar-candy.default                          # sddm theme
      trellis-cli.default
      browserstack.default
      pkgs.libsForQt5.sddm-kcm                        # sddm theme installer
      pkgs.libsForQt5.kdeconnect-kde
      pkgs.libsForQt5.gwenview
      pkgs.libsForQt5.plasma-thunderbolt              # plasma integration for controlling Thunderbolt devicesx
      pkgs.xclip                                      # command line interface to X selections (clipboard)
      pkgs.xsel                                       # manipulate the X selection
      pkgs.xfce.thunar                                # xfce file manager
      pkgs.xfce.thunar-volman                         # Thunar extension for automatic management of removable drives and media
      pkgs.xfce.thunar-dropbox-plugin                 # A plugin that adds context-menu items for Dropbox to Thunar
      pkgs.xfce.thunar-archive-plugin                 # Thunar plugin providing file context menus for archives
      pkgs.xfce.thunar-media-tags-plugin              # Thunar plugin providing tagging and renaming features for media files
      pkgs.dolphin                                    # kde file manager
      pkgs.ngrok                                      # expose a web server running on your local machine to the internet
      pkgs.neofetch                                   # system info script
      pkgs.libnotify                                  # a library that sends desktop notifications to a notification daemon
      pkgs.cachix                                     # cli client for Nix binary cache hostin
      pkgs.lxappearance                               # configuring the theme and fonts of gtk apps
      pkgs.xarchiver                                  # frontend to 7z, zip, rar, tar, bzip2, gzip, arj, lha, rpm and deb
      pkgs.jetbrains.phpstorm                         # professional IDE for Web and PHP developers
      pkgs.jetbrains.pycharm-community
      pkgs.poedit
      pkgs.postman
      pkgs.figma-linux
      pkgs.vlc
      pkgs.libreoffice
      pkgs.# qmk
      pkgs.spotifyd
      pkgs.xkeysnail
      pkgs.yubioath-flutter
      pkgs.handbrake                                  # A tool for converting video files and ripping DVDs
      pkgs.sddm-chili-theme                           # sddm theme
      pkgs.pciutils                                   # collection of programs for inspecting and manipulating configuration of PCI devices
      (pkgs.python3.withPackages python-pkgs)  # python 3 with extensions
      pkgs.maia-icon-theme
      pkgs.rhythmbox
      pkgs.playerctl
      pkgs.pw-volume
      pkgs.xdotool
      pkgs.google-fonts
      pkgs.# swappy
      pkgs.# swaylock
      pkgs.# wl-clipboard
      pkgs.# wlr-randr
      pkgs.# wofi
      pkgs.krita
      pkgs.inkscape
      pkgs.blender
      pkgs.gimp
      pkgs.darktable
      pkgs.libsForQt5.kdenlive
      pkgs.davinci-resolve
      pkgs.pro-office-calculator
      pkgs.libsecret
      pkgs.gnome.gnome-calendar
      pkgs.pika-backup
      pkgs.# Audio
      pkgs.ladspaPlugins
      pkgs.lsp-plugins
      pkgs.pipewire
      pkgs.wireplumber
    ];
  };
}
