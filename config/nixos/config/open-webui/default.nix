{ pkgs, inputs, ... }:
{

  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
    openFirewall = true;
    host = "0.0.0.0";
  };
}
