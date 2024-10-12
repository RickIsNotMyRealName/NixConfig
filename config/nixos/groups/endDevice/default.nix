{ config, pkgs, ... }:
{
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "632ea290851d869e"
    ];
  };

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
}
