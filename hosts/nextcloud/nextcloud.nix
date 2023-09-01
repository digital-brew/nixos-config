{ config, pkgs, lib, ... }:

{
  security.acme = {
    acceptTerms = true;
    email = "rafal+nextcloud@digitalbrew.io";
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
      "cloud.digitalbrew.io" = {
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
      hostName = "cloud.digitalbrew.io";

      # Use HTTPS for links
      https = true;

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
  };
}