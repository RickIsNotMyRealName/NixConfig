{ pkgs, inputs, ... }:
{

  services.open-webui = {
    enable = true;
    package = pkgs.open-webui; # TODO: Switch back to unstable once it's missing dependencies are fixed
    openFirewall = true;
    host = "0.0.0.0";
    environment = {
      PYDANTIC_SKIP_VALIDATING_CORE_SCHEMAS = "True";
    };
  };
}
