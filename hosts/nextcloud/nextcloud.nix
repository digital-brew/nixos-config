{ config, pkgs, lib, ... }:

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
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit news contacts calendar tasks;
    };
#    extraApps = {
#      mail = pkgs.fetchNextcloudApp rec {
#        url = "https://github.com/nextcloud-releases/mail/releases/download/v1.14.1/mail-v1.14.1.tar.gz";
#        sha256 = "sha256-sQUsYC3cco6fj9pF2l1NrCEhA3KJoOvJRhXvBlVpNqo=";
#      };
#      contacts = pkgs.fetchNextcloudApp rec {
#        url = "https://github.com/nextcloud-releases/contacts/releases/download/v4.2.2/contacts-v4.2.2.tar.gz";
#        sha256 = "sha256-eTc51pkg3OdHJB7X4/hD39Ce+9vKzw1nlJ7BhPOzdy0=";
#      };
#    };
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
  services.maddy = {
    enable = true;
    hostname = "${config.services.nextcloud.hostName}";
    primaryDomain = "${config.services.nextcloud.hostName}";
    # Disable any sender validation checks
    config = lib.concatStrings (
      builtins.match "(.*)authorize_sender.*identity\n[ ]+\}(.*)" options.services.maddy.config.default
    );
  };

  # Configure local mail delivery
  programs.msmtp = {
    enable = true;
    accounts.default = {
      host = "${config.services.nextcloud.hostName}";
      port = 587;
      auth = "login";
      tls = "off";
      from = "rafal+nextcloud@digitalbrew.io";
      user = "rafal+nextcloud@digitalbrew.io";
      password = "GJTerbbYaLpf8gi8T7utMVePmqiHBiQ4P9iaQwFAK9ZYUrrB";
    };
  };
}