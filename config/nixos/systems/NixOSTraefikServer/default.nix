{ modulesPath, pkgs, config, lib, ... }:
{
  imports = [
    ../../config/traefik/default.nix
  ];

  myConfig = {
    secrets = [
      "traefik.env"
    ];
  };
}
