{ config, pkgs, lib, ... }:

{
  systemd.services."nextcloud-setup" = {
    requires = ["mysql.service"];
    after = ["mysql.service"];
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

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    home = "/srv/lib/nextcloud";
    hostName = "cloud.digitalbrew.io";
    https = true;
    maxUploadSize = "1024M";
    config = {
      adminuser = "moonlander";
      adminpassFile = "/var/secrets/admin-pass";
      dbtype = "mysql";
      dbuser = "nextcloud";
      dbname = "nextcloud";
    };
  };
}