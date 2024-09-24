{ config, lib, pkgs, ... }:

let
  cfg = config.services.actual-server;
  dataDir = "/var/lib/actual-server";
  cfgContent = builtins.toJSON {
    inherit dataDir;
    inherit (cfg) hostname port;
    serverFiles = "${dataDir}/server-files";
    userFiles = "${dataDir}/user-files";
  };
in
{
  options = {
    services.actual-server = {
      enable = lib.mkEnableOption "Enable actual-server";
      hostname = lib.mkOption {
        type = lib.types.str;
        default = "localhost";
        description = "Hostname to bind to";
      };
      port = lib.mkOption {
        type = lib.types.int;
        default = 5006;
        description = "Port to bind to";
      };
      user = lib.mkOption {
        type = lib.types.str;
        default = "actual";
        description = "User to run as";
      };
      group = lib.mkOption {
        type = lib.types.str;
        default = "actual";
        description = "Group to run as";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Declare the actual.json file under /etc
    environment.etc."actual.json".text = builtins.toJSON {
      inherit dataDir;
      inherit (cfg) hostname port;
      serverFiles = "${dataDir}/server-files";
      userFiles = "${dataDir}/user-files";
    };

    users.users."${cfg.user}" = {
      isSystemUser = true;
      group = cfg.group;
    };

    users.groups."${cfg.group}" = { };

    systemd.services.actual-server = {
      description = "Actual budget server";
      documentation = [ "https://actualbudget.org/docs/" ];
      wantedBy = [ "multi-user.target" ];
      after = [ "networking.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.actual-server}/bin/actual";
        User = cfg.user;
        Group = cfg.group;
        Restart = "on-failure";
        RestartSec = "5s";
        StandardOutput = "journal";
        StandardError = "journal";
        Environment = [
          "ACTUAL_CONFIG_PATH=/etc/actual.json"
        ];
      };
    };

    system.activationScripts.actual-server = ''
      mkdir -p ${dataDir}/server-files
      mkdir -p ${dataDir}/user-files
      chown -R ${cfg.user}:${cfg.group} ${dataDir}
    '';
  };
}
