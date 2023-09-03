{ config, pkgs, lib, ... }:

{
  services.nextcloud = {
      enable = true;
      home = "/srv/lib/nextcloud";
      hostName = "cloud.digitalbrew.io";
      https = true;
      maxUploadSize = "1024M";
      config = {
        adminuser = "moonlander";
        adminpassFile = "/var/nextcloud/admin-pass";
        dbtype = "mysql";
        dbhost = "localhost";
        dbport = "3306";
        dbuser = "nextcloud";
        dbpassFile = "/var/nextcloud/db-pass";
        dbname = "nextcloud";
        dbtableprefix = "oc_";
      };
      caching = {
        apcu = true;
        memcached = true;
        redis = false;
      };
    };
}