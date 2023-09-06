{ config, pkgs, lib, ... }:
let
  customcss = pkgs.fetchNextcloudApp rec {
    url = "https://github.com/juliushaertl/theming_customcss/releases/download/v1.14.0/theming_customcss.tar.gz";
    sha256 = "sha256-tNTr4teb5K9GGERzyxksowNe4EVYbhQYNjvgaQ0B9JM=";
  };
in
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    home = "/srv/lib/nextcloud";
    hostName = "cloud.digitalbrew.io";
    https = true;
    maxUploadSize = "1024M";
    # Auto-update Nextcloud Apps
    autoUpdateApps.enable = true;
    # Set what time makes sense for you
    autoUpdateApps.startAt = "03:00:00";
    extraApps = {
      theming_customcss = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/juliushaertl/theming_customcss/releases/download/v1.14.0/theming_customcss.tar.gz";
        sha256 = "sha256-tNTr4teb5K9GGERzyxksowNe4EVYbhQYNjvgaQ0B9JM=";
      };
      contacts = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/nextcloud-releases/contacts/releases/download/v5.4.0-rc1/contacts-v5.4.0-rc1.tar.gz";
        sha256 = "sha256-/0TzLHFX0+QlN15UaBzIQWeng/uQ9YKhDLVBHsqPCYQ=";
      };
      calendar = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/nextcloud-releases/calendar/releases/download/v4.4.4/calendar-v4.4.4.tar.gz";
        sha256 = "sha256-ASHF9mT2EHoanwqUSDstXQmmQDIQA5WsNuGk74poRhk=";
      };
      notes = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/nextcloud-releases/notes/releases/download/v4.8.1/notes.tar.gz";
        sha256 = "sha256-7GkTGyGTvtDbZsq/zOdbBE7xh6DZO183W6I5XX1ekbw=";
      };
      deck = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/nextcloud-releases/deck/releases/download/v1.10.0/deck-v1.10.0.tar.gz";
        sha256 = "sha256-ASHF9mT2EHoanwqUSDstXQmmQDIQA5WsNuGk74poRhk=";
      };
      groupfolders = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/nextcloud-releases/groupfolders/releases/download/v15.0.2/groupfolders-v15.0.2.tar.gz";
        sha256 = "sha256-ASHF9mT2EHoanwqUSDstXQmmQDIQA5WsNuGk74poRhk=";
      };
      mail = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/nextcloud-releases/mail/releases/download/v3.3.1/mail-v3.3.1.tar.gz";
        sha256 = "sha256-ASHF9mT2EHoanwqUSDstXQmmQDIQA5WsNuGk74poRhk=";
      };
#      breezedark = pkgs.fetchNextcloudApp rec {
#        url = "https://github.com/mwalbeck/nextcloud-breeze-dark/releases/download/v26.0.0/breezedark.tar.gz";
#        sha256 = "sha256-ASHF9mT2EHoanwqUSDstXQmmQDIQA5WsNuGk74poRhk=";
#      };
      cospend = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/julien-nc/cospend-nc/releases/download/v1.5.10/cospend-1.5.10.tar.gz";
        sha256 = "sha256-ASHF9mT2EHoanwqUSDstXQmmQDIQA5WsNuGk74poRhk=";
      };
#      money = pkgs.fetchNextcloudApp rec {
#        url = "https://github.com/powerpaul17/nc_money/releases/download/v0.20.0/money.tar.gz";
#        sha256 = "sha256-ASHF9mT2EHoanwqUSDstXQmmQDIQA5WsNuGk74poRhk=";
#      };
      apporder = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/juliushaertl/apporder/releases/download/v0.15.0/apporder.tar.gz";
        sha256 = "sha256-JtWkZSlmMD8Cki5UVdHV7+wKQ+ldQMF36cN7THnbods=";
      };
#      appointments = pkgs.fetchNextcloudApp rec {
#        url = "https://github.com/SergeyMosin/Appointments/raw/v1.15.3/build/artifacts/appstore/appointments.tar.gz";
#        sha256 = "sha256-XgBwUr26qW6wvqhrnhhhhcN4wkI+eXDHnNSm1HDbP6M=";
#      };
#      weather = pkgs.fetchNextcloudApp rec {
#        url = "https://github.com/nextcloud/weather/releases/download/1.7.7/weather-1.7.7.tar.gz";
#        sha256 = "sha256-XgBwUr26qW6wvqhrnhhhhcN4wkI+eXDHnNSm1HDbP6M=";
#      };
#      Cookbook = pkgs.fetchNextcloudApp rec {
#        url = "https://github.com/nextcloud/cookbook/releases/download/v0.10.2/Cookbook-0.10.2.tar.gz";
#        sha256 = "sha256-XgBwUr26qW6wvqhrnhhhhcN4wkI+eXDHnNSm1HDbP6M=";
#      };
    };
     extraAppsEnable = true;
#    caching = {
#      apcu = true;
#      memcached = true;
#      redis = false;
#    };
    config = {
      adminuser = "moonlander";
      adminpassFile = "/var/secrets/admin-pass";
      dbtype = "mysql";
      dbuser = "nextcloud";
      dbname = "nextcloud";
    };
  };

  systemd.services."nextcloud-setup" = {
    requires = ["mysql.service"];
    after = ["mysql.service"];
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "rafal+nextcloud@digitalbrew.io";
  };

  services.nginx = {
    enable = true;
    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      ${config.services.nextcloud.hostName} = {
        ## Force HTTP redirect to HTTPS
        forceSSL = true;
        ## LetsEncrypt
        enableACME = true;
      };
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      { name = "nextcloud";
        ensurePermissions = {
          "nextcloud.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };

 # Setup mail server
#  services.maddy = {
#    enable = true;
#    hostname = "digitalbrew.io";
#    primaryDomain = "digitalbrew.io";
#    # Disable any sender validation checks
##    config = lib.concatStrings (
##      builtins.match "(.*)authorize_sender.*identity\n[ ]+\}(.*)" options.services.maddy.config.default
##    );
#  };

  # Configure local mail delivery
#  programs.msmtp = {
#    enable = true;
#    accounts.default = {
#      host = "digitalbrew.io";
#      port = 465;
#      auth = "login";
#      tls = "off";
#      from = "info@digitalbrew.io";
#      user = "info@digitalbrew.io";
#      password = "dB2FYkeCR!GHvP@HJyTEcLTF2Wu!q-n";
#    };
#  };
}