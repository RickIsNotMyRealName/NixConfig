/*
  { config, lib, pkgs, ... }:

  with lib;

  let
  cfg = config.services.traefik;
  jsonValue = with types;
  let
      valueType = nullOr (oneOf [
        bool
        int
        float
        str
        (lazyAttrsOf valueType)
        (listOf valueType)
      ]) // {
        description = "JSON value";
        emptyValue.value = { };
      };
  in valueType;
  dynamicConfigFile = if cfg.dynamicConfigFile == null then
  pkgs.runCommand "config.toml" {
      buildInputs = [ pkgs.remarshal ];
      preferLocalBuild = true;
  } ''
      remarshal -if json -of toml \
        < ${
          pkgs.writeText "dynamic_config.json"
          (builtins.toJSON cfg.dynamicConfigOptions)
        } \
        > $out
  ''
  else
  cfg.dynamicConfigFile;
  staticConfigFile = if cfg.staticConfigFile == null then
  pkgs.runCommand "config.toml" {
      buildInputs = [ pkgs.yj ];
      preferLocalBuild = true;
  } ''
      yj -jt -i \
        < ${
          pkgs.writeText "static_config.json" (builtins.toJSON
            (recursiveUpdate cfg.staticConfigOptions {
              providers.file.filename = "${dynamicConfigFile}";
            }))
        } \
        > $out
  ''
  else
  cfg.staticConfigFile;

  finalStaticConfigFile =
  if cfg.environmentFiles == []
  then staticConfigFile
  else "/run/traefik/config.toml";
  in {
  options.services.traefik = {
  enable = mkEnableOption "Traefik web server";

  staticConfigFile = mkOption {
      default = null;
      example = literalExpression "/path/to/static_config.toml";
      type = types.nullOr types.path;
      description = ''
        Path to traefik's static configuration to use.
        (Using that option has precedence over `staticConfigOptions` and `dynamicConfigOptions`)
      '';
  };

  staticConfigOptions = mkOption {
      description = ''
        Static configuration for Traefik.
      '';
      type = jsonValue;
      default = { entryPoints.http.address = ":80"; };
      example = {
        entryPoints.web.address = ":8080";
        entryPoints.http.address = ":80";

        api = { };
      };
  };

  dynamicConfigFile = mkOption {
      default = null;
      example = literalExpression "/path/to/dynamic_config.toml";
      type = types.nullOr types.path;
      description = ''
        Path to traefik's dynamic configuration to use.
        (Using that option has precedence over `dynamicConfigOptions`)
      '';
  };

  dynamicConfigOptions = mkOption {
      description = ''
        Dynamic configuration for Traefik.
      '';
      type = jsonValue;
      default = { };
      example = {
        http.routers.router1 = {
          rule = "Host(`localhost`)";
          service = "service1";
        };

        http.services.service1.loadBalancer.servers =
          [{ url = "http://localhost:8080"; }];
      };
  };

  dataDir = mkOption {
      default = "/var/lib/traefik";
      type = types.path;
      description = ''
        Location for any persistent data traefik creates, ie. acme
      '';
  };

  group = mkOption {
      default = "traefik";
      type = types.str;
      example = "docker";
      description = ''
        Set the group that traefik runs under.
        For the docker backend this needs to be set to `docker` instead.
      '';
  };

  package = mkPackageOption pkgs "traefik" { };

  environmentFiles = mkOption {
      default = [];
      type = types.listOf types.path;
      example = [ "/run/secrets/traefik.env" ];
      description = ''
        Files to load as environment file. Environment variables from this file
        will be substituted into the static configuration file using envsubst.
      '';
  };
  };

  config = mkIf cfg.enable {
  systemd.tmpfiles.rules = [ "d '${cfg.dataDir}' 0700 traefik traefik - -" ];

  systemd.services.traefik = {
      description = "Traefik web server";
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      startLimitIntervalSec = 86400;
      startLimitBurst = 5;
      serviceConfig = {
        EnvironmentFile = cfg.environmentFiles;
        ExecStartPre = lib.optional (cfg.environmentFiles != [])
          (pkgs.writeShellScript "pre-start" ''
            umask 077
            ${pkgs.envsubst}/bin/envsubst -i "${staticConfigFile}" > "${finalStaticConfigFile}"
          '');
        ExecStart = "${cfg.package}/bin/traefik --configfile=${finalStaticConfigFile}";
        Type = "simple";
        User = "traefik";
        Group = cfg.group;
        Restart = "on-failure";
        AmbientCapabilities = "cap_net_bind_service";
        CapabilityBoundingSet = "cap_net_bind_service";
        NoNewPrivileges = true;
        LimitNPROC = 64;
        LimitNOFILE = 1048576;
        PrivateTmp = true;
        PrivateDevices = true;
        ProtectHome = true;
        ProtectSystem = "full";
        ReadWritePaths = [ cfg.dataDir ];
        RuntimeDirectory = "traefik";
      };
  };

  users.users.traefik = {
      group = "traefik";
      home = cfg.dataDir;
      createHome = true;
      isSystemUser = true;
  };

  users.groups.traefik = { };
  };
  }
*/
/*
  - 192.168.1.10-192.168.1.19 - Servers/Services
  - 192.168.1.10:444,81 - TrueNAS Server
  - 192.168.1.11 - TrueNAS set as kubernetes node ip as well.
  - 192.168.1.11:31012  - Actual Budget (Not used anymore)
  - 192.168.1.12:53,80 - PiHole
  - 192.168.1.13:8123 - Home Assistant
  - 192.168.1.14:8006 - Proxmox (PVE) Server
  - 192.168.1.16 - **Free**
  - 192.168.1.17:8443 - UniFi Controller
  - 192.168.1.18: - **Free**
  - 192.168.1.22 - Cloudflared
  - 192.168.1.23:5006: Actual Budget
  - 192.168.1.24:8081 - nixos-Traefik
  - 192.168.1.25:8080 - KeyCloak
  - 192.168.1.27:3000 - Homepage
*/

{ ... }:
{


  # Open ports for Traefik
  networking.firewall.allowedTCPPorts = [ 80 443 8081 ];

  # Create directories for Traefik
  # The traefik group/user should have read/write access to /var/log/traefik and /var/lib/traefik
  systemd.tmpfiles.rules = [
    "d /var/log/traefik 0755 traefik traefik"
    "d /var/lib/traefik 0755 traefik traefik"
  ];

  myConfig = {
    secrets = [
      "traefik.env"
    ];
  };

  services.traefik = {
    enable = false;

    environmentFiles = [ "/run/secrets/traefik.env" ];

    staticConfigOptions = {
      # Entry points
      entryPoints = {
        web = {
          address = ":80";
          http = {
            redirections.entryPoint = {
              to = "websecure";
              scheme = "https";
            };
          };
        };
        websecure = {
          address = ":443";
          http = {
            tls = {
              certResolver = "staging";
            };
          };
        };
        traefik = {
          address = ":8081";
        };
      };

      # API dashboard (optional, for monitoring and debugging)
      api = {
        dashboard = true;
        insecure = true;
        debug = false;
      };

      # Log
      log = {
        level = "TRACE";
        format = "json";
        filePath = "/var/log/traefik/traefik.log";
      };
      accessLog = {
        format = "json";
        filePath = "/var/log/traefik/access.log";
      };
      # tracing = { };

      # Certificates
      ## Let's Encrypt
      certificatesResolvers.letsencrypt.acme.email = "joshkrahn@protonmail.com";
      certificatesResolvers.letsencrypt.acme.storage = "/var/lib/traefik/acme.json";
      certificatesResolvers.letsencrypt.acme.tlsChallenge = { };

      ## Staging
      certificatesResolvers.staging.acme.email = "joshkrahn@protonmail.com";
      certificatesResolvers.staging.acme.storage = "/var/lib/traefik/acme-staging.json";
      certificatesResolvers.staging.acme.caServer = "https://acme-staging-v02.api.letsencrypt.org/directory";
      certificatesResolvers.staging.acme.tlsChallenge = { };

      serversTransport.insecureSkipVerify = true;
      tcpServersTransport.tls.insecureSkipVerify = true;

    };


    dynamicConfigOptions = {
      http = {
        services = {
          testService.loadBalancer = {
            servers = [
              { url = "https://192.168.1.14:8006"; }
            ];
          };
          trueNASService.loadBalancer = {
            servers = [
              { url = "https://192.168.1.10:444"; }
            ];
          };
          piHoleService.loadBalancer = {
            servers = [
              { url = "http://192.168.1.12/admin/login.php"; }
            ];
          };
          homeAssistantService.loadBalancer = {
            servers = [
              { url = "http://192.168.1.13:8123"; }
            ];
          };
          proxmoxService.loadBalancer = {
            servers = [
              { url = "https://192.168.1.14:8006"; }
            ];
          };
          unifiService.loadBalancer = {
            servers = [
              { url = "https://192.168.1.17:8443"; }
            ];
          };
          nixosTraefikService.loadBalancer = {
            servers = [
              { url = "http://192.168.1.24:8081/dashboard/"; }
            ];
          };
          keycloakService.loadBalancer = {
            servers = [
              { url = "http://192.168.1.25:8080"; }
            ];
          };
          homepageService.loadBalancer = {
            servers = [
              { url = "http://192.168.1.27:3000"; }
            ];
          };
        };

        routers = {
          testRouter = {
            rule = "Host(`test.tden.xyz`)";
            service = "testService";
            entryPoints = [ "websecure" ];

          };
          trueNASRouter = {
            rule = "Host(`truenas.tden.xyz`)";
            service = "trueNASService";
            entryPoints = [ "websecure" ];

          };
          piHoleRouter = {
            rule = "Host(`pihole.tden.xyz`)";
            service = "piHoleService";
            entryPoints = [ "websecure" ];

          };
          homeAssistantRouter = {
            rule = "Host(`homeassistant.tden.xyz`)";
            service = "homeAssistantService";
            entryPoints = [ "websecure" ];

          };
          proxmoxRouter = {
            rule = "Host(`proxmox.tden.xyz`)";
            service = "proxmoxService";

          };
          unifiRouter = {
            rule = "Host(`unifi.tden.xyz`)";
            service = "unifiService";
            entryPoints = [ "websecure" ];

          };
          nixosTraefikRouter = {
            rule = "Host(`traefik.tden.xyz`)";
            service = "nixosTraefikService";
            entryPoints = [ "websecure" ];

          };
          keycloakRouter = {
            rule = "Host(`auth.tden.xyz`)";
            service = "keycloakService";
            entryPoints = [ "websecure" ];

          };
          homepageRouter = {
            rule = "Host(`tden.xyz`) || Host(`www.tden.xyz`) || Host(`homepage.tden.xyz`)";
            service = "homepageService";
            entryPoints = [ "websecure" ];
          };
        };
      };
    };
  };
}
