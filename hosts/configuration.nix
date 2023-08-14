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
  # Systemd-boot EFI boot loader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };
  };

  systemd.network.wait-online.enable = false;

  # Time zone
  time.timeZone = "Europe/London";

  # Internationalisation properties
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Hack Nerd Font Propo";
    keyMap = "pl";
  };

  # Hostname
  networking = {
    hostName = "DBi9XRL";
    hosts = {
      "127.0.0.1" = [ 
        "local.stratus.earth" 
        "local.nades.com"
        ];
    };
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
      enable = false;
      allowedTCPPorts = [ 22 80 443 4040 ];
      allowedUDPPorts = [ 22 80 443 4040 ];
    };
  };

  # Enable the X11 windowing system
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xfce = {
          enable = true;
        };
      };
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          # config = ./../../.config/xmonad/xmonad.hs;
        };

        qtile = {
          enable = true;
          backend = "x11";
          # package = pkgs.qtile-unwrapped.overrideAttrs(o: {
          #   src = pkgs.fetchFromGitHub {
          #     repo = "qtile";
          #     owner = "digital-brew";
          #     rev = "f46450eef6eb2fab5e6a1037fe46893a8c8cc0ce";
          #     sha256 = "sha256-U2I4yWLSkCao5FXWVd+MqI0IvCw9qUWlzW8+RJtQ26Q=";
          #   };
          # });
          extraPackages = python3Packages: with python3Packages; [
            qtile-extras
          ];
        };
      };
      displayManager = {
        sddm = {
          enable = true;
          theme = "sugar-candy";
          settings = {
            General = {
              ScreenWidth = "1920";
              ScreenHeight = "1080";
              FormPosition = "center"; 
              CursorTheme = "BreezeX-Light";
              CursorSize = 28;
            };
          };
        };
        defaultSession = "none+qtile";
        setupCommands = ''
          SCREEN_0="eDP-1"
          SCREEN_1="DP-2"
          SCREEN_2="DVI-I-1-1"
          SCREEN_3="DVI-I-2-2"

          if ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr | grep "$SCREEN_1 connected"; then
              ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --output $SCREEN_0 --off --output $SCREEN_1 --mode 1920x1080 --output $SCREEN_2 --primary --mode 1920x1080 --left-of $SCREEN_1 --output $SCREEN_3 --mode 1920x1080 --right-of $SCREEN_1 &
          else
              ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --output $SCREEN_0 --mode 1440x900 &
          fi
        '';
        sessionCommands = ''
          ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
          ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
              Xcursor.theme: BreezeX-Light
              Xcursor.size: 28
            ''}
        '';
      };
      videoDrivers = [ "displaylink" "modesetting" ];
      layout = "pl";
    };
    # SSH
    openssh = {
      enable = true;
      ports = [ 22 ];
      knownHosts = {
        id_ed_muchmore.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRmj+PlCNU7I3eH7kK/uW+vbR9eG3SdIbEFfNT/VU39 rafal@muchmorecreative.co.uk";
        id_ed_digitalbrew.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDRpDYY6c5pggmFbgCGT/9+wu4nOI0EQ1/d53RHiFySx rafal@digitalbrew.io";
        id_rsa.publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8p6AFFYtjzqgm+I8T9QR+BtrRE9o02umcnvpKrYZNnCSknAEbuRqQDUUUsRWGEed4PP1j762JJsfyi+CQmxjxoIfAS77vBccerQsUsEQs7B5BF61tkvZhJw6Rpncv/luEw+yJm/7WvzC2ffftMgYhxSSTa21ZCGQJq7ZYck5rOzqR7y+A/oBVm6FVX2WqmdZWFYkLhEOvsrt8oPVz61b9i9IwD98HoBon5wFLEx1XZuPq3sYi0zw7VKMHoa5NsEZq0WiOfRviDRVPB2eyYbN24J4ZQjgHbh3JfBnsrd7c/MgtGNtcJEwGGCBxkb/EwsdImX6HWFgos3rU/+toRFyjTFExMN6M7ucL8HmHCJws1rP7SjMQ7sZr9DHoNZNvr9/xhlVe4xM9jMdCeoUnzRNap6Z2nymj03aG8r0mVziwz80HwtbAlAI2LBGuaDVr+ZnH/J3gCJ8GekfG8mCij5KY4s58zPaFRgZQKMFTP/yk5+CjOgL0OyYczHnxww6L7pi1By63KRT72r1KooEeYwHIbKEF+IQFpLTYNfbWxl8+6zLVB47SLyfZIdwUuWasSLOXZldbYbjNDJPrjj0j9gJRcpnQE2owIjuevmEromY/Kc10wk7ZF2t56JMHNoJ4+7l9g4EAdMje2S/sVLdwIfJI9JNleprQfjKq1Xy8Pc4VBw== rafal@burstofcode.com";
      };
    };
  };

#  services.dbus.packages = [ pkgs.gnome3.evolution-data-server ];
#  services.udev.packages = [ pkgs.bolt ];

  # Enable MySQL
  services.mysql = {
    enable = false;
    user = "root";
    package = pkgs.mariadb;
  };
  
  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.alsa.enable = true;
  hardware.pulseaudio.enable = false;

  # Define a user account
  users.users.moonlander = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "kvm" "libvirtd" ];
    openssh = {
      authorizedKeys.keyFiles = [];
    };
    packages = with pkgs; [
      rofi
      rofi-power-menu
      rofi-calc
      rofi-emoji
      dmenu
      vscodium
      brave
      epiphany
      chromium
      google-chrome
      google-chrome-dev
      firefox
      firefox-devedition
      librewolf
      nitrogen
      thunderbird
      libsForQt5.breeze-gtk
      _1password-gui
      signal-desktop
      slack
      telegram-desktop
      skypeforlinux
      discord
      freetube
      ruby
      zoom-us
      teams-for-linux
      caffeine-ng
      gnome.gnome-disk-utility
      junction
      rose-pine-gtk-theme
      rose-pine-icon-theme
    ];
  };
 
  nixpkgs.config.allowUnfree = true;
  
  # Environment
  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; 
    let 
      sddm-theme-sugar-dark = pkgs.callPackage ../modules/themes/sddm-sugar-dark.nix {}; 
      sddm-theme-sugar-candy = pkgs.callPackage ../modules/themes/sddm-sugar-candy.nix {}; 
    in [
      sddm-theme-sugar-dark.default                           # sddm theme
      sddm-theme-sugar-candy.default                          # sddm theme
      libsForQt5.sddm-kcm                        # sddm theme installer
      libsForQt5.kdeconnect-kde
      libsForQt5.gwenview
      libsForQt5.plasma-thunderbolt              # plasma integration for controlling Thunderbolt devicesx
      gnumake                                    # tool to control the generation of non-source files from sources
      gcc13                                      # gnu compiler collection
      curl                                       # command line tool for transferring files with URL syntax
      xorg.xrandr                                # configuration utility to the RandR (Resize and Rotate) X Window System extension
      xorg.xsetroot                              # root window parameter setting utility for X
      wget                                       # non-interactive network downloader
      killall                                    # kill processes by name
      xorg.xkill                                 # kill a client by its X resource - by click on window
      htop                                       # interactive process viewer
      btop                                       # a monitor of system resources
      xclip                                      # command line interface to X selections (clipboard)
      xsel                                       # manipulate the X selection
      firefox                                    # browser
      xfce.thunar                                # xfce file manager
      dolphin                                    # kde file manager
      ranger                                     # cli based file manager
      direnv                                     # shell extension that manages your environment
      zsh                                        # the z shell
      zip                                        # compressor/archiver for creating and modifying zipfiles
      unzip                                      # an extraction utility for archives compressed in .zip format
      lsof                                       # list open files
#     .feh                                        # image viewer
      ngrok                                      # expose a web server running on your local machine to the internet
      neofetch                                   # system info script
      libnotify                                  # a library that sends desktop notifications to a notification daemon
#     .flameshot                                  # screenshot software
      cachix                                     # cli client for Nix binary cache hostin
      lshw                                       # provide info on the hardware configuration
      lxappearance                               # configuring the theme and fonts of gtk apps
      xarchiver                                  # frontend to 7z, zip, rar, tar, bzip2, gzip, arj, lha, rpm and deb
      jetbrains.phpstorm                         # professional IDE for Web and PHP developers
      jetbrains.pycharm-community
      poedit
      postman
      figma-linux
      vlc
      onlyoffice-bin
      # qmk
      spotifyd
      glibc
      xkeysnail
      alsa-utils
      yubioath-flutter
      virtualboxWithExtpack
      ansible_2_14
      ack                                        # a grep-like tool tailored to working with large trees of source code
      fd                                         # A simple, fast and user-friendly alternative to find
      gh                                         # GitHub CLI tool
      handbrake                                  # A tool for converting video files and ripping DVDs
      sddm-chili-theme                           # sddm theme
      thunderbolt                                # thunderbolt(TM) user-space components
      betterbird
      pciutils                                   # collection of programs for inspecting and manipulating configuration of PCI devices
      (python3.withPackages python-pkgs)  # python 3 with extensions
      maia-icon-theme
      rhythmbox
      playerctl
      pw-volume
      xdotool
      # swappy
      # swaylock
      # wl-clipboard
      # wlr-randr
      # wofi
      # krita
      # inkscape
      # blender
      # gimp
      # darktable
      # libsForQt5.kdenlive
      # davinci-resolve
      vscode
    ];
  };

  # programs = {
  #   waybar.enable = true;
  #   hyprland = {
  #     enable = true;
  #     xwayland = {
  #       enable = true;
  #       hidpi = true;
  #     };
  #   };
  # };

  # Fonts
  fonts = {
    fontconfig = {
      antialias = true;
      subpixel.rgba = "rgb";
      hinting = {
        enable = true;
        style = "full";
      };
      defaultFonts.serif = [ "Ubuntu" ];
      defaultFonts.sansSerif = [ "Ubuntu" ];
      defaultFonts.monospace = [ "Ubuntu Mono" ];
    };
    packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
        ubuntu_font_family
        nerdfonts
        font-awesome_5
        material-icons
      ];
  };

  system.stateVersion = "23.05"; # Did you read the comment?

  nix = {
    settings.trusted-users = ["root" "moonlander"];
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs(
        _: { src = builtins.fetchTarball {
          url = "https://install.devenv.sh/latest";
          sha256 = "0pml1x6pzmdp6h19257by1x5b25smi2y60l1z40mi58aimdp59ss";
        }; }
      );

      ngrok = super.ngrok.overrideAttrs(
        _: { src = builtins.fetchTarball {
          url = "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz";
          sha256 = "0m0dd71y29g30j7y5j0qwbf934kjkvcf89sx9g88lx6lgam2qlj4";
        }; }
      );

      betterbird = super.betterbird.overrideAttrs(
        _: { src = builtins.fetchTarball {
          url = "https://www.betterbird.eu/downloads/115-Preview/betterbird-115.1.0-bb8.en-US.linux-x86_64.tar.bz2";
          sha256 = "0xppbjpq2n3c97rznixrvn57z05d7ama8w99fw3awwcfjrfdk9vw";
        }; }
      );

#      devenv = super.devenv.overrideAttrs(
#        _: { src = builtins.fetchTarball {
#          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
#          sha256 = "0wj5455mk0kgm4vnvqia6x4qhkwwf3cn07pdsd4wmfdbp9rxr44a";
#        }; }
#      );
    })
  ];
}
