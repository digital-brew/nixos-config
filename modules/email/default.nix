# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: EMAIL
# Type: Module (HomeManager)
# Location: /modules/email/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, inputs, extraConfig, ... }:
let
  username = extraConfig.mainUser.username;
in
{
  options.customModules.email = {
    enable = lib.mkEnableOption "Whether to enable email services, thunderbird, account settings.";
  };

  config = lib.mkIf config.customModules.email.enable {
    home-manager.users.${username} = {
      programs.thunderbird.enable = true;
      programs.thunderbird.profiles = {
        "rafal@digitalbrew.io" = {
          isDefault = true;
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
    };
  };
}
