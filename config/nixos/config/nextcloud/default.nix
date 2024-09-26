{ lib, pkgs, ... }:
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

  environment.systemPackages = with pkgs; [
    exiftool
    ffmpeg-full
    nodejs
    libtensorflow
  ];

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "cloud.tden.xyz";
    home = "/mnt/DataDrive/";
    datadir = "/mnt/DataDrive/";
    enableImagemagick = true;

    appstoreEnable = true;
    extraAppsEnable = true;
    extraApps = {
      inherit (pkgs.nextcloud29Packages.apps) calendar contacts memories previewgenerator tasks;
      facerecognition = pkgs.fetchNextcloudApp {
        sha256 = "sha256-0xt/fBP8VoWefvDeiyr/h7qfxQF8SCcXP9bL7L2t17U=";
        url = "https://github.com/matiasdelellis/facerecognition/releases/download/v0.9.51/facerecognition.tar.gz";
        license = "lgpl3";
      };
      # Ensure that you install `recognize` in the app store.
    };
    config = {
      adminpassFile = "/run/secrets/adminpassFile";
      adminuser = "admin";
    };

    settings = {
      trusted_domains = [ "localhost" "192.168.1.19" "cloud.tden.xyz" "192.168.1.22" ];
      trusted_proxies = [ "192.168.1.19" "192.168.1.22" ];
      overwriteprotocol = "https";

      memories.exiftool = "${lib.getExe pkgs.exiftool}";
      memories.vod.ffmpeg = "${pkgs.ffmpeg}/bin/ffmpeg";
      memories.vod.ffprobe = "${pkgs.ffmpeg}/bin/ffprobe";
    };

    database.createLocally = true;
    configureRedis = true;
  };
}
