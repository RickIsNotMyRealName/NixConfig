{ config, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers = {
      backend = "podman";
      containers = {
        "open-webui" = {
          autoStart = true;
          image = "ghcr.io/open-webui/open-webui";
          ports = [ "3000:8080" ];
          # TODO figure out how to create the data directory declaratively
          volumes = [ "${config.users.users."joshk".home}/open-webui:/app/backend/data" ];
          environment = {
            OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
            OLLAMA_BASE_URL = "http://127.0.0.1:11434";
          };
          extraOptions =
            [
              "--pull=newer"
              "--name=open-webui"
              "--hostname=open-webui"
              "--network=host"
              "--add-host=host.containers.internal:host-gateway"
            ];
        };
      };
    };
  };
  networking.firewall = { allowedTCPPorts = [ 80 443 8080 11434 3000 ]; };
}
