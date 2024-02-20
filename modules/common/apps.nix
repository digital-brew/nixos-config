# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: APPS (COMMON)
# Type: Module (NixOS)
# Location: /modules/common/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
#  nixpkgs.config = {
#    permittedInsecurePackages = [
#      "electron-11.5.0"
#      "electron-24.8.6"
##      "figma-linux-0.11.2"
#    ];
#  };

  environment.systemPackages = with pkgs; [
    _1password-gui
    _7zz                                      # Command line archiver utility
    ack                                       # a grep-like tool tailored to working with large trees of source code
    brightnessctl                             # This program allows you read and control device brightness
    caffeine-ng                               # Status bar application to temporarily inhibit screensaver and sleep mode
    cinnamon.nemo-with-extensions             # File browser for Cinnamon
    cinnamon.folder-color-switcher            # Change folder colors for Nemo and Caja
    cinnamon.nemo-fileroller                  # Nemo file roller extension
    curl                                      # command line tool for transferring files with URL syntax
    dmenu                                     # A generic, highly customizable, and efficient menu for the X Window System
    fan2go                                    # A simple daemon providing dynamic fan speed control based on temperature sensors
    fd                                        # A simple, fast and user-friendly alternative to find
    filezilla                                 # Graphical FTP, FTPS and SFTP client
    glxinfo                                   # Test utilities for OpenGL
    gnome.cheese                              # Take photos and videos with your webcam, with fun graphical effects
    gnome.gnome-disk-utility                  # A udisks graphical front-end
    gnumake                                   # A tool to control the generation of non-source files from sources
    guvcview                                  # A simple interface for devices supported by the linux UVC driver
    jq                                        # A lightweight and flexible command-line JSON processor
    killall                                   # kill processes by name
    libsecret                                 # A library for storing and retrieving passwords and other secrets
    lm_sensors                                # Tools for reading hardware sensors
    lsof                                      # list open files
    lshw                                      # provide info on the hardware configuration
    inetutils                                 # Collection of common network programs
    maim                                      # A command-line screenshot utility
    neofetch                                  # A fast, highly customizable system info script
    nitrogen                                  # A wallpaper browser and setter for X11
    openssl                                   # A cryptographic library that implements the SSL and TLS protocols
    pciutils                                  # collection of programs for inspecting and manipulating configuration of PCI devices
    pkg-config                                # A tool that allows packages to find out information about other packages (wrapper script)
    qmk                                       # A program to help users work with QMK Firmware
    ranger                                    # cli based file manager
    rclone                                    # Command line program to sync files and directories to and from major cloud storage
    scrot                                     # A command-line screen capture utility
    sl                                        # Steam Locomotive runs across your terminal when you type 'sl'
    socat                                     # Utility for bidirectional data transfer between two independent data channels
    xarchiver                                 # GTK frontend to 7z,zip,rar,tar,bzip2, gzip,arj, lha, rpm and deb (open and extract only)
    xclip                                     # command line interface to X selections (clipboard)
    xdotool                                   # Fake keyboard/mouse input, window management, and more
    xfce.thunar                               # xfce file manager
    xfce.thunar-volman                        # Thunar extension for automatic management of removable drives and media
    xfce.thunar-dropbox-plugin                # A plugin that adds context-menu items for Dropbox to Thunar
    xfce.thunar-archive-plugin                # Thunar plugin providing file context menus for archives
    xfce.thunar-media-tags-plugin             # Thunar plugin providing tagging and renaming features for media files
    xorg.xrandr                               # configuration utility to the RandR (Resize and Rotate) X Window System extension
    xorg.xsetroot                             # root window parameter setting utility for X
    xorg.xkill                                # kill a client by its X resource - by click on window
    xsel                                      # manipulate the X selection
    ulauncher                                 # A fast application launcher for Linux, written in Python, using GTK
    unzip                                     # an extraction utility for archives compressed in .zip format
    yubioath-flutter                          # Yubico Authenticator for Desktop
    v4l-utils                                 # V4L utils and libv4l, provide common image formats regardless of the v4l device
    wget                                      # non-interactive network downloader
    wmctrl                                    # CLI tool to interact with EWMH/NetWM compatible X Window Managers
    zip                                       # compressor/archiver for creating and modifying zipfiles
  ];
}
