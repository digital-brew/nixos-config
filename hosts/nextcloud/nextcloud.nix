{ config, pkgs, lib, ... }:

{
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

    # Only allow PFS-enabled ciphers with AES256
    sslCiphers = "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384";

    # Setup Nextcloud virtual host to listen on ports
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
    enable = false;
    user = "admin";
    package = pkgs.mariadb;
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    hostName = "cloud.digitalbrew.io";

    # Use HTTPS for links
    https = true;

    configureRedis = true;

    # Auto-update Nextcloud Apps
    autoUpdateApps.enable = true;
    # Set what time makes sense for you
    autoUpdateApps.startAt = "03:00:00";

    config = {
      # Further forces Nextcloud to use HTTPS
      overwriteProtocol = "https";

      # Nextcloud PostegreSQL database configuration, recommended over using SQLite
      dbtype = "mysql";
      dbuser = "nextcloud";
      dbhost = "localhost"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      dbpassFile = "/var/nextcloud/db-pass";

      adminpassFile = "/var/nextcloud/admin-pass";
      adminuser = "admin";
    };

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
  };
}