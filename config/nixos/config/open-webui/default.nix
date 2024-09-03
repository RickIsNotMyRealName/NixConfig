{ pkgs, inputs, ... }:
{

  services.open-webui = {
    enable = true;
    package = pkgs.pinned.open-webui;
    openFirewall = true;
    host = "0.0.0.0";
  };
}
