{ pkgs, ... }:
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    package = pkgs.homepage-dashboard;
  };
}
