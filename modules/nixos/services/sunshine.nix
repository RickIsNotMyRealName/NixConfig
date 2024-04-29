{ config, lib, pkgs, ... }:

let
  cfg = config.services.sunshine;
in
{
  options.services.sunshine = with lib; {
    enable = mkEnableOption "sunshine service for self-hosted game streaming";

    autoStart = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to automatically start the sunshine service at boot.";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPortRanges = [{ from = 47984; to = 48010; }];
    networking.firewall.allowedUDPPortRanges = [{ from = 47998; to = 48010; }];

    security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
    };

    systemd.user.services.sunshine = {
      description = "Sunshine self-hosted game stream host for Moonlight";
      after = [ "network.target" ]; # Ensure network is up before starting
      wants = [ "network.target" ];
      startLimitBurst = 5;
      startLimitIntervalSec = 500;
      serviceConfig = {
        ExecStart = "${config.security.wrapperDir}/sunshine";
        Restart = "on-failure";
        RestartSec = "5s";
        # Ensure the service has the necessary environment, e.g., DISPLAY for GUI applications
        # Environment = "DISPLAY=:0";
      };
      wantedBy = lib.optional cfg.autoStart "default.target";
    };
  };
}
