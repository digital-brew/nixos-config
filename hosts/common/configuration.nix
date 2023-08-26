{ config, pkgs, lib, ... }:
let

in
{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-11.5.0"
    ];
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

  # Enable the X11 windowing system
  services.xserver = {
    enable = true;
    layout = "pl";
  };

  # Define a user account
  users.users.moonlander = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "kvm" "libvirtd" ];
    openssh = {
      authorizedKeys.keyFiles = [];
    };
  };

  environment.systemPackages = with pkgs; [
    gnumake                                    # tool to control the generation of non-source files from sources
    gcc13                                      # gnu compiler collection
    curl                                       # command line tool for transferring files with URL syntax
    xorg.xrandr                                # configuration utility to the RandR (Resize and Rotate) X Window System extension
    xorg.xsetroot                              # root window parameter setting utility for X
    wget                                       # non-interactive network downloader
    killall                                    # kill processes by name
    xorg.xkill                                 # kill a client by its X resource - by click on window
    # htop                                       # interactive process viewer
    # btop                                       # a monitor of system resources
    # git
    ranger                                     # cli based file manager
    # zsh                                        # the z shell
    zip                                        # compressor/archiver for creating and modifying zipfiles
    unzip                                      # an extraction utility for archives compressed in .zip format
    lsof                                       # list open files
    lshw                                       # provide info on the hardware configuration
    glibc
    ack                                        # a grep-like tool tailored to working with large trees of source code
    fd                                         # A simple, fast and user-friendly alternative to find
    # gh                                         # GitHub CLI tool
  ];


  fonts = {
      fontconfig = {
        antialias = true;
        subpixel.rgba = "rgb";
        hinting = {
          enable = true;
          style = "full";
        };
        defaultFonts.serif = [ "Hack Nerd Font Propo" ];
        defaultFonts.sansSerif = [ "Hack Nerd Font Propo" ];
        defaultFonts.monospace = [ "Hack Nerd Font Propo" ];
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

    nix = {
      settings = {
        trusted-users = ["root" "moonlander"];
        auto-optimise-store = true;
      };
      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
        warn-dirty = false
      '';
    };

    system.stateVersion = "23.05"; # Did you read the comment?
}