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
#      inherit news contacts calendar tasks mail notes;
#      customcss = pkgs.fetchNextcloudApp rec {
#        url = "https://github.com/juliushaertl/theming_customcss/releases/download/v1.14.0/theming_customcss.tar.gz";
#        sha256 = "sha256-tNTr4teb5K9GGERzyxksowNe4EVYbhQYNjvgaQ0B9JM=";
#      };
      mail = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/nextcloud-releases/mail/releases/download/v3.4.0-rc.1/mail-v3.4.0-rc.1.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
      contacts = pkgs.fetchNextcloudApp rec {
        url = "https://github.com/nextcloud-releases/contacts/releases/download/v5.4.0-rc1/contacts-v5.4.0-rc1.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
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