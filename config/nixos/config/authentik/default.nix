# config/nixos/config/authentik/default.nix
{ pkgs, inputs, ... }:
{
  imports = [
    inputs.authentik-nix.nixosModules.default
  ];

  myConfig = {
    secrets = [
      "authentik.env"
    ];
  };

  environment.systemPackages = with pkgs; [
    authentik
  ];

  services.authentik = {
    enable = false;
    environmentFile = "/run/secrets/authentik.env";
    settings = {
      # email = {
      #   host = "smtp.protonmail.ch";
      #   port = 587;
      #   # username = "authentik@example.com";
      #   use_tls = true;
      #   use_ssl = true;
      #   from = "authentik@example.com";
      # };
      disable_startup_analytics = true;
      avatars = "initials";
    };
  };

}
