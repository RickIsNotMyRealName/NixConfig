{ pkgs, ... }:
{
  myConfig = {
    secrets = {
      "homepage-dashboard.env" = { };
    };
  };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    package = pkgs.homepage-dashboard;
    environmentFile = "/run/secrets/homepage-dashboard.env";
    bookmarks = [
      {
        Developer = [
          {
            Github = [
              {
                abbr = "GH";
                href = "https://github.com/";
              }
            ];
          }
        ];
      }
      {
        Social = [
          {
            Reddit = [
              {
                abbr = "RE";
                href = "https://reddit.com/";
              }
            ];
          }
        ];
      }
      {
        Entertainment = [
          {
            YouTube = [
              {
                abbr = "YT";
                href = "https://youtube.com/";
              }
            ];
          }
        ];
      }
    ];
    services = [
      {
        Services = [
          {
            Proxmox = {
              icon = "proxmox.png";
              href = "https://proxmox.tden.xyz";
              widget = {
                type = "proxmox";
                url = "https://192.168.1.14:8006";
                username = "{{HOMEPAGE_VAR_Proxmox_Username}}";
                password = "{{HOMEPAGE_VAR_Proxmox_Password}}";
              };
            };
          }
          {
            TrueNAS = {
              icon = "truenas.png";
              href = "https://truenas.tden.xyz";
              widget = {
                type = "truenas";
                url = "https://truenas.tden.xyz";
                key = "{{HOMEPAGE_VAR_TrueNAS_API_Key}}";
                enablePools = true;
                nasType = "scale";
              };
            };
          }
          {
            PiHole = {
              icon = "pi-hole.png";
              href = "http://192.168.1.12/admin/login.php";
              widget = {
                type = "pihole";
                url = "http://192.168.1.12";
                key = "{{HOMEPAGE_VAR_PiHole_API_Key}}";
              };
            };
          }
          {
            HomeAssistant = {
              icon = "home-assistant.png";
              href = "https://homeassistant.tden.xyz";
              widget = {
                type = "homeassistant";
                url = "https://homeassistant.tden.xyz";
                key = "{{HOMEPAGE_VAR_HomeAssistant_API_Key}}";
              };
            };
          }

          {
            ProxmoxCloudflareTunnel = {
              icon = "cloudflare.png";
              href = "https://one.dash.cloudflare.com/{{HOMEPAGE_VAR_Cloudflare_Account_ID}}/networks/tunnels";
              widget = {
                type = "cloudflared";
                accountid = "{{HOMEPAGE_VAR_Cloudflare_Account_ID}}";
                tunnelid = "{{HOMEPAGE_VAR_Cloudflare_Tunnel_ID}}";
                key = "{{HOMEPAGE_VAR_Cloudflare_Tunnel_Key}}";
              };
            };
          }
          {
            TrueNASCloudflareTunnel = {
              icon = "cloudflare.png";
              href = "https://one.dash.cloudflare.com/{{HOMEPAGE_VAR_Cloudflare_Account_ID}}/networks/tunnels";
              widget = {
                type = "cloudflared";
                accountid = "{{HOMEPAGE_VAR_Cloudflare_Account_ID}}";
                tunnelid = "{{HOMEPAGE_VAR_Cloudflare_Tunnel_ID_2}}";
                key = "{{HOMEPAGE_VAR_Cloudflare_Tunnel_Key}}";
              };
            };
          }
          {
            ActualBudget = {
              icon = "https://budget.tden.xyz/favicon.ico";
              href = "https://budget.tden.xyz/";
              siteMonitor = "https://budget.tden.xyz/";
            };
          }
          {
            Keycloak = {
              icon = "https://auth.tden.xyz/resources/m7nor/admin/keycloak.v2/favicon.svg";
              href = "https://auth.tden.xyz/admin/master/console/";
              siteMonitor = "https://auth.tden.xyz/admin/master/console/";
            };
          }
        ];
      }
    ];
    widgets = [
      {
        resources = {
          cpu = true;
          memory = true;
          disk = "/";
        };
      }
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        };
      }
    ];
  };
}
