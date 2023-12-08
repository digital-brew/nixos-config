{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/services/dunst.nix
#    ../../modules/home-manager/services/flameshot.nix
#    ../../modules/home-manager/services/picom.nix
    ../../modules/home-manager/services/sxhkd.nix
    ../../modules/home-manager/programs/alacritty.nix
    ../../modules/home-manager/programs/kitty.nix
    ../../modules/home-manager/programs/obs.nix
    ../../modules/home-manager/programs/rofi.nix
    ../../modules/home-manager/programs/git.nix
  ];

  # home.file.".config/qtile".source = ./../../dotfiles/qtile;
#  file.".config/wall".source = ../modules/themes/wall;
#  file.".config/wall.mp4".source = ../modules/themes/wall.mp4;

#  home.file.".ssh/id_ed_digitalbrew".source = ./../../dotfiles/ssh/id_ed_digitalbrew;
#  home.file.".ssh/id_ed_digitalbrew.pub".source = ./../../dotfiles/ssh/id_ed_digitalbrew.pub;
#  home.file.".ssh/id_ed_muchmore".source = ./../../dotfiles/ssh/id_ed_muchmore;
#  home.file.".ssh/id_ed_muchmore.pub".source = ./../../dotfiles/ssh/id_ed_muchmore.pub;
#  home.file.".ssh/id_rsa".source = ./../../dotfiles/ssh/id_rsa;
#  home.file.".ssh/id_rsa.pub".source = ./../../dotfiles/ssh/id_rsa.pub;

  home.file.".npmrc".source = ./../../dotfiles/node/npmrc;

  home = {
    packages = with pkgs; [
      dmenu
      brave
      epiphany
      google-chrome
      librewolf
      nitrogen
      _1password-gui
      signal-desktop
      slack
      telegram-desktop
      skypeforlinux
      freetube
      ruby
      caffeine-ng
      gnome.gnome-disk-utility
      junction
      rose-pine-gtk-theme
      rose-pine-icon-theme
      clockify
#      mailspring
      swaylock-effects
    ];

    pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      gtk.enable = true;
      name = "Breeze_Snow";
      package = pkgs.libsForQt5.breeze-gtk;
      size = 16;
    };
  };

  programs = {
#   swaylock.enable = true;
   wlogout.enable = true;
   chromium.enable = true;
   firefox.enable = true;
   direnv = {
    enable = true;
    enableZshIntegration = true;
   };                     # shell extension that manages your environment
   jq.enable = true;
   sioyek.enable = true;                      # PDF reader
   thunderbird = {
      enable = true;
      profiles = {
        "rafal@digitalbrew.io" = {
          isDefault = true;
          userContent = ''
            #folderPane {
              background-color: #1A1B26;
            }
          '';
        };
        "rafal@muchmorecreative.co.uk" = {
          isDefault = false;
        };
        "rafal@mailowl.co" = {
          isDefault = false;
        };
        "info@digitalbrew.io" = {
          isDefault = false;
        };
        "rafal@burstofcode.com" = {
          isDefault = false;
        };
        "hello@burstofcode.com" = {
          isDefault = false;
        };
        "rafal.pajak@icloud.com" = {
          isDefault = false;
        };
      };
   };
  };

  services = {
    swayidle.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    nextcloud-client.enable = true;
    network-manager-applet.enable = true;
  };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Adwaita-dark";
    };
    iconTheme = {
      name = "rose-pine";
    };
  };

#  qt = {
#    enable = true;
#  };

  systemd.user.targets.tray = {               # Tray.target can not be found when xsession is not enabled. This fixes the issue.
   Unit = {
     Description = "Home Manager System Tray";
     Requires = [ "graphical-session-pre.target" ];
    };
  };

  accounts.email.accounts = {
    "rafal@digitalbrew.io" = {
      thunderbird = {
        enable = true;
      };
      primary = true;
      address = "rafal@digitalbrew.io";
      imap = {
        host = "imap.dreamhost.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp.dreamhost.com";
        port = 465;
        tls.enable = true;
      };
      userName = "rafal@digitalbrew.io";
      realName = "Rafal";
    };
    "rafal@muchmorecreative.co.uk" = {
      thunderbird = {
        enable = true;
      };
      address = "rafal@muchmorecreative.co.uk";
      imap = {
        host = "imap.dreamhost.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp.dreamhost.com";
        port = 465;
        tls.enable = true;
      };
      userName = "rafal@muchmorecreative.co.uk";
      realName = "Rafal";
    };
    "rafal@mailowl.co" = {
      thunderbird = {
        enable = true;
      };
      address = "rafal@mailowl.co";
      imap = {
        host = "imap.dreamhost.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp.dreamhost.com";
        port = 465;
        tls.enable = true;
      };
      userName = "rafal@mailowl.co";
      realName = "Rafal";
    };
    "info@digitalbrew.io" = {
      thunderbird = {
        enable = true;
      };
      address = "info@digitalbrew.io";
      imap = {
        host = "imap.dreamhost.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp.dreamhost.com";
        port = 465;
        tls.enable = true;
      };
      userName = "info@digitalbrew.io";
      realName = "Rafal";
    };
    "rafal@burstofcode.com" = {
      thunderbird = {
        enable = true;
      };
      address = "rafal@burstofcode.com";
      imap = {
        host = "imap.dreamhost.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp.dreamhost.com";
        port = 465;
        tls.enable = true;
      };
      userName = "rafal@burstofcode.com";
      realName = "Rafal";
    };
    "hello@burstofcode.com" = {
      thunderbird = {
        enable = true;
      };
      address = "hello@burstofcode.com";
      imap = {
        host = "imap.dreamhost.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp.dreamhost.com";
        port = 465;
        tls.enable = true;
      };
      userName = "hello@burstofcode.com";
      realName = "Rafal";
    };
    "rafal.pajak@icloud.com" = {
      thunderbird = {
        enable = true;
      };
      address = "rafal.pajak@icloud.com";
      imap = {
        host = "imap.mail.me.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp.mail.me.com";
        port = 587;
        tls.enable = true;
      };
      userName = "rafal.pajak@icloud.com";
      realName = "Rafal";
    };
  };

  wayland.windowManager = {
    sway = {
      enable = true;
    };
  };

  home.file."nixos-config/dotfiles/waybar/colors.css".text = ''
    /**
      Color scheme name: Ayu Mirage
      Color scheme url: https://github.com/tinted-theming/base16-schemes/blob/main/ayu-mirage.yaml
    **/

    @define-color background #${config.colorScheme.colors.base01};
    /* @define-color backgroundAlpha #${config.colorScheme.colors.base01}80; */

    @define-color foreground #${config.colorScheme.colors.base07};
    /* @define-color foregroundAlpha #${config.colorScheme.colors.base07}80; */


    @define-color color00 #${config.colorScheme.colors.base00};
    /* @define-color color00Alpha #${config.colorScheme.colors.base00}80; */

    @define-color color01 #${config.colorScheme.colors.base01};
    /* @define-color color01Alpha #${config.colorScheme.colors.base01}80; */

    @define-color color02 #${config.colorScheme.colors.base02};
    /* @define-color color02Alpha #${config.colorScheme.colors.base02}80; */

    @define-color color03 #${config.colorScheme.colors.base03};
    /* @define-color color03Alpha #${config.colorScheme.colors.base03}80; */

    @define-color color04 #${config.colorScheme.colors.base04};
    /* @define-color color04Alpha #${config.colorScheme.colors.base04}80; */

    @define-color color05 #${config.colorScheme.colors.base05};
    /* @define-color color05Alpha #${config.colorScheme.colors.base05}80; */

    @define-color color06 #${config.colorScheme.colors.base06};
    /* @define-color color06Alpha #${config.colorScheme.colors.base06}80; */

    @define-color color07 #${config.colorScheme.colors.base07};
    /* @define-color color07Alpha #${config.colorScheme.colors.base07}80; */

    @define-color color08 #${config.colorScheme.colors.base08};
    /* @define-color color08Alpha #${config.colorScheme.colors.base08}80; */

    @define-color color09 #${config.colorScheme.colors.base09};
    /* @define-color color09Alpha #${config.colorScheme.colors.base09}80; */

    @define-color color0A #${config.colorScheme.colors.base0A};
    /* @define-color color0AAlpha #${config.colorScheme.colors.base0A}80; */

    @define-color color0B #${config.colorScheme.colors.base0B};
    /* @define-color color0BAlpha #${config.colorScheme.colors.base0B}80; */

    @define-color color0C #${config.colorScheme.colors.base0C};
    /* @define-color color0CAlpha #${config.colorScheme.colors.base0C}80; */

    @define-color color0D #${config.colorScheme.colors.base0D};
    /* @define-color color0DAlpha #${config.colorScheme.colors.base0D}80; */

    @define-color color0E #${config.colorScheme.colors.base0E};
    /* @define-color color0EAlpha #${config.colorScheme.colors.base0E}80; */

    @define-color color0F #${config.colorScheme.colors.base0F};
    /* @define-color color0FAlpha #${config.colorScheme.colors.base0F}80; */
  '';
}
