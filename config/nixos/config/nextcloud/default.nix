{ pkgs, ... }:
{
  myConfig = {
    secrets = {
      "adminpassFile" = {
        owner = "nextcloud";
      };
    };
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "nextcloud.tden.xyz";
    config = {
      adminpassFile = "/run/secrets/adminpassFile";
    };
  };
}
