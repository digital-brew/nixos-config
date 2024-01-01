{ lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ack                                       # a grep-like tool tailored to working with large trees of source code
    appimage-run                              # Run appimage packages on NixOS
    btop                                      # A monitor of resources
    curl                                      # command line tool for transferring files with URL syntax
    fd                                        # A simple, fast and user-friendly alternative to find
    gnumake                                   # A tool to control the generation of non-source files from sources
    killall                                   # kill processes by name
    lsof                                      # list open files
    lshw                                      # provide info on the hardware configuration
    ranger                                    # cli based file manager
    xorg.xrandr                               # configuration utility to the RandR (Resize and Rotate) X Window System extension
    xorg.xsetroot                             # root window parameter setting utility for X
    xorg.xkill                                # kill a client by its X resource - by click on window
    unzip                                     # an extraction utility for archives compressed in .zip format
    wget                                      # non-interactive network downloader
    zip                                       # compressor/archiver for creating and modifying zipfiles
  ];
}
