{ config, pkgs, lib, nix-alien, ... }:
let
  python-pkgs = ps: with ps; [
    pandas
    requests
    pip
    pillow
    passlib
    resolvelib
    pyyaml
    packaging
    markupsafe
    jinja2
    cryptography
    ansible-core
    ansible
    virtualenv
  ];
in
{
  # Systemd-boot EFI boot loader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 28;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };
  };

  nixpkgs.config = {
    permittedInsecurePackages = [
      "electron-11.5.0"
      "electron-24.8.6"
#      "figma-linux-0.11.2"
    ];
  };

  # make EVDI kernel module compile
#  nixpkgs.config.allowBroken = true;

  systemd.network.wait-online.enable = false;

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
      allowedTCPPorts = [ 22 80 443 631 32016 4040 2019 57621 65432 ];
      allowedUDPPorts = [ 22 80 443 631 32016 4040 2019 5353 65432 ];
    };
  };

  # Needed for Dell D6000 dockind station
  # Source: https://nixos.wiki/wiki/Displaylink
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Enable CUPS to print documents
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  services.printing = {
    enable = true;
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All

      BrowseProtocols all
    '';
  };

  # Enable for Mailspring
#  services.gnome.gnome-keyring.enable = true;

  # Enable sound
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
  };
  hardware.pulseaudio.enable = false;
  systemd.user.services.pipewire.environment = {
    LADSPA_PATH = "${pkgs.ladspaPlugins}/lib/ladspa";
  };

  services.mpd.enable = true;
  services.pcscd.enable = true;

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

  environment.etc."/udev/rules.d/30-amdgpu-pm.rules".text = ''
    KERNEL=="card1", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="low"
  '';

  systemd.services.t2fand = {
    enable = true;
    description = "A simple daemon to control fan speed on Macs with T2 chip";
    unitConfig = {
      Type = "simple";
    };
    serviceConfig = {
      Restart = "always";
      RestartSec = 2;
      ExecStart = "/run/current-system/sw/bin/python3 /run/current-system/sw/bin/t2fand";
    };
    wantedBy = [ "default.target" ];
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages =
    let
      sddm-theme-sugar-dark = pkgs.callPackage ../../modules/nixos/themes/sddm-sugar-dark.nix {};
      sddm-theme-sugar-candy = pkgs.callPackage ../../modules/nixos/themes/sddm-sugar-candy.nix {};
      trellis-cli = pkgs.callPackage ../../modules/nixos/packages/trellis-cli.nix {};
      stripe-cli = pkgs.callPackage ../../modules/nixos/packages/stripe-cli.nix {};
      hyprland-workspaces = pkgs.callPackage ../../modules/nixos/packages/hyprland-workspaces.nix {};
      eww-stray = pkgs.callPackage ../../modules/nixos/packages/eww-stray.nix {};
      eww-wayland = pkgs.callPackage ../../modules/nixos/packages/eww-wayland.nix {};
      continuedev = pkgs.callPackage ../../modules/nixos/packages/continuedev.nix {};
      macbook-pro-t2-fans = pkgs.callPackage ../../modules/nixos/packages/macbook-pro-t2-fans.nix {};
      browserstack = pkgs.callPackage ../../modules/nixos/packages/browserstack.nix {};
      tableplus = pkgs.callPackage ../../modules/nixos/packages/tableplus.nix {};
    in [
      sddm-theme-sugar-dark.default                           # sddm theme
      sddm-theme-sugar-candy.default                          # sddm theme
      trellis-cli.default
#      tableplus.default
      stripe-cli.default
      macbook-pro-t2-fans.default
#      hyprland-workspaces
#      continuedev.default
#      eww-stray
#      pkgs.linuxKernel.packages.linux_6_6.evdi
      pkgs.eww-wayland
      pkgs.pkg-config
      pkgs.yarn
#      browserstack.default
#      pkgs.libsForQt5.sddm-kcm                        # sddm theme installer
#      pkgs.libsForQt5.kdeconnect-kde
#      pkgs.libsForQt5.gwenview
#      pkgs.libsForQt5.plasma-thunderbolt              # plasma integration for controlling Thunderbolt devicesx
      pkgs.xclip                                      # command line interface to X selections (clipboard)
      pkgs.xsel                                       # manipulate the X selection
      pkgs.xfce.thunar                                # xfce file manager
      pkgs.xfce.thunar-volman                         # Thunar extension for automatic management of removable drives and media
      pkgs.xfce.thunar-dropbox-plugin                 # A plugin that adds context-menu items for Dropbox to Thunar
      pkgs.xfce.thunar-archive-plugin                 # Thunar plugin providing file context menus for archives
      pkgs.xfce.thunar-media-tags-plugin              # Thunar plugin providing tagging and renaming features for media files
#      pkgs.dolphin                                    # kde file manager
      pkgs.ngrok                                      # expose a web server running on your local machine to the internet
      pkgs.neofetch                                   # system info script
      pkgs.libnotify                                  # a library that sends desktop notifications to a notification daemon
      pkgs.cachix                                     # cli client for Nix binary cache hostin
      pkgs.lxappearance                               # configuring the theme and fonts of gtk apps
      pkgs.xarchiver                                  # frontend to 7z, zip, rar, tar, bzip2, gzip, arj, lha, rpm and deb
      pkgs.phpstorm                         # professional IDE for Web and PHP developers
      pkgs.diffuse
      pkgs.kdiff3
      pkgs.tkdiff
      pkgs.jetbrains.pycharm-community
      pkgs.poedit
      pkgs.rose-pine-icon-theme
      pkgs.pantheon.elementary-icon-theme
#      pkgs.poetry
      pkgs.discord
      pkgs.beekeeper-studio
      pkgs.dbeaver
#      pkgs.figma-linux
      pkgs.vlc
      pkgs.libreoffice
      pkgs.qmk
      pkgs.aspell
      pkgs.aspellDicts.pl
      pkgs.aspellDicts.en
      pkgs.inetutils
      pkgs.sshpass
#      pkgs.thunderbird
      pkgs.betterbird
#      pkgs.spotifyd
      pkgs.xkeysnail
      pkgs.yubioath-flutter
      pkgs.handbrake                                  # A tool for converting video files and ripping DVDs
      pkgs.sddm-chili-theme                           # sddm theme
      pkgs.pciutils                                   # collection of programs for inspecting and manipulating configuration of PCI devices
      (pkgs.python310.withPackages python-pkgs)         # python 3 with extensions
      pkgs.maia-icon-theme
      pkgs.rhythmbox
#      pkgs.ansible
#      pkgs.zoom
      pkgs.playerctl
      pkgs.pw-volume
      pkgs.xdotool
      pkgs.vscode
      pkgs.google-fonts
      pkgs.krita
      pkgs.inkscape
      pkgs.blender
      pkgs.gimp
      pkgs.darktable
      pkgs.libsForQt5.kdenlive
      pkgs.libsForQt5.gwenview
#      pkgs.davinci-resolve
      pkgs.pro-office-calculator
      pkgs.libsecret
      pkgs.gnome.gnome-calendar
      pkgs.imagemagick
      pkgs.spotify
      pkgs.cinnamon.nemo-with-extensions
      pkgs.cinnamon.folder-color-switcher
      pkgs.cinnamon.nemo-fileroller
      pkgs.wlr-randr
      pkgs.scrot
      pkgs.maim
#      pkgs.zoom-us
#      pkgs.pika-backups
      # Audio
      pkgs.pulseaudio
      pkgs.ladspaPlugins
      pkgs.lsp-plugins
      pkgs.pipewire
      pkgs.wireplumber
      pkgs.colordiff
      pkgs.lm_sensors
      pkgs.pavucontrol
      pkgs.filezilla
      pkgs.glxinfo
      pkgs.socat
      pkgs.cliphist
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  qt = {
    enable = true;
  };
}
