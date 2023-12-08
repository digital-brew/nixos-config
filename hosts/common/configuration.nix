{ config, pkgs, lib, ... }:
let
  id_rsa = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8p6AFFYtjzqgm+I8T9QR+BtrRE9o02umcnvpKrYZNnCSknAEbuRqQDUUUsRWGEed4PP1j762JJsfyi+CQmxjxoIfAS77vBccerQsUsEQs7B5BF61tkvZhJw6Rpncv/luEw+yJm/7WvzC2ffftMgYhxSSTa21ZCGQJq7ZYck5rOzqR7y+A/oBVm6FVX2WqmdZWFYkLhEOvsrt8oPVz61b9i9IwD98HoBon5wFLEx1XZuPq3sYi0zw7VKMHoa5NsEZq0WiOfRviDRVPB2eyYbN24J4ZQjgHbh3JfBnsrd7c/MgtGNtcJEwGGCBxkb/EwsdImX6HWFgos3rU/+toRFyjTFExMN6M7ucL8HmHCJws1rP7SjMQ7sZr9DHoNZNvr9/xhlVe4xM9jMdCeoUnzRNap6Z2nymj03aG8r0mVziwz80HwtbAlAI2LBGuaDVr+ZnH/J3gCJ8GekfG8mCij5KY4s58zPaFRgZQKMFTP/yk5+CjOgL0OyYczHnxww6L7pi1By63KRT72r1KooEeYwHIbKEF+IQFpLTYNfbWxl8+6zLVB47SLyfZIdwUuWasSLOXZldbYbjNDJPrjj0j9gJRcpnQE2owIjuevmEromY/Kc10wk7ZF2t56JMHNoJ4+7l9g4EAdMje2S/sVLdwIfJI9JNleprQfjKq1Xy8Pc4VBw== rafal@burstofcode.com";
  id_ed_digitalbrew = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDRpDYY6c5pggmFbgCGT/9+wu4nOI0EQ1/d53RHiFySx rafal@digitalbrew.io";
  id_ed_muchmore = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRmj+PlCNU7I3eH7kK/uW+vbR9eG3SdIbEFfNT/VU39 rafal@muchmorecreative.co.uk";
  id_ed_nextcloud = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMmSKyXPX7BIsAnFso0NsOb5FT0XNRVi0KTrP2QX3tiQ rafal@digitalbrew.io";


in
{
  nixpkgs.config = {
    allowUnfree = true;
  };

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

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Define a user account
  users.users.root.openssh.authorizedKeys.keys = [id_rsa id_ed_digitalbrew id_ed_muchmore id_ed_nextcloud];
  users.users.moonlander = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "kvm" "libvirtd" "input" ];
    openssh.authorizedKeys.keys = [id_rsa id_ed_digitalbrew id_ed_muchmore id_ed_nextcloud];
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
    ranger                                     # cli based file manager
    zip                                        # compressor/archiver for creating and modifying zipfiles
    unzip                                      # an extraction utility for archives compressed in .zip format
    lsof                                       # list open files
    lshw                                       # provide info on the hardware configuration
    glibc
    ack                                        # a grep-like tool tailored to working with large trees of source code
    fd                                         # A simple, fast and user-friendly alternative to find
    openssl
    appimage-run
  ];

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };


  fonts = {
      fontconfig = {
        antialias = true;
        subpixel.rgba = "rgb";
        hinting = {
          enable = true;
          style = "full";
        };
        defaultFonts.serif = [ "Be Vietnam Pro, Semibold" ];
        defaultFonts.sansSerif = [ "Be Vietnam Pro, Semibold" ];
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
      '';
    };

    system.stateVersion = "23.05"; # Did you read the comment?
}