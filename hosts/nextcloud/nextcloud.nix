{ config, pkgs, lib, ... }:

{

    systemd.services."nextcloud-setup" = {
      requires = ["postgresql.service"];
      after    = ["postgresql.service"];
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "rafal@digitalbrew.io";
    };

   services.nginx = {
      enable = true;

      # Use recommended settings
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      # Only allow PFS-enabled ciphers with AES256
  #    sslCiphers = "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384";

      # Setup Nextcloud virtual host to listen on ports
      virtualHosts = {
        ${config.services.nextcloud.hostName} = {
           ## Force HTTP redirect to HTTPS
           forceSSL = true;
           ## LetsEncrypt
           enableACME = true;
        };
#        "localhost".listen = [ { addr = "127.0.0.1"; port = 8080; } ];
      };
    };

    services.postgresql = {
      package = pkgs.postgresql_15;
      enable = true;
      dataDir = "/var/lib/postgresql";
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [{
        name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }];
    };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
#    user = "root";
  };

  services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud27;
      home = "/srv/lib/nextcloud";
      hostName = "cloud.digitalbrew.io";
      https = true;
      maxUploadSize = "1024M";
  #    config = {
  #      adminuser = "moonlander";
  #      adminpassFile = "/var/secrets/admin-pass";
  #      dbtype = "mysql";
  #      dbhost = "localhost";
  #      dbport = "3306";
  #      dbuser = "nextcloud";
  #      dbpassFile = "/var/secrets/db-pass";
  #      dbname = "nextcloud";
  #      dbtableprefix = "oc_";
  #    };
      config = {
        adminuser = "moonlander";
        adminpassFile = "/var/secrets/admin-pass";
        dbtype = "pgsql";
        dbhost = "/run/postgresql/${config.services.postgresql.package.psqlSchema}";
        dbuser = "nextcloud";
        dbpassFile = "/var/secrets/db-pass";
        dbname = "nextcloud";
        overwriteProtocol = "https";
      };
  #    caching = {
  #      apcu = true;
  #      memcached = true;
  #      redis = false;
  #    };
    };

}