{ pkgs, ... }:
{
  myConfig = {
    secrets = {
      "adminpassFile" = {
        owner = "nextcloud";
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 ];
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "cloud.tden.xyz";
    home = "/mnt/DataDrive/";
    datadir = "/mnt/DataDrive/";
    config = {
      adminpassFile = "/run/secrets/adminpassFile";
      adminuser = "admin";
    };
    settings = {
      trusted_domains = [ "localhost" "192.168.1.19" "cloud.tden.xyz" "192.168.1.22" ];
      trusted_proxies = [ "192.168.1.19" "192.168.1.22" ];
      overwriteprotocol = "https";
    };
    database.createLocally = true;
    configureRedis = true;
  };
}