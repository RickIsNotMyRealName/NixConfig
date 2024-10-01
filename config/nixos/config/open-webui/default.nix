{ pkgs, inputs, ... }:
{

  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
    openFirewall = true;
    host = "0.0.0.0";
    environment = {
      PYDANTIC_SKIP_VALIDATING_CORE_SCHEMAS = "True";
    };
  };
}
