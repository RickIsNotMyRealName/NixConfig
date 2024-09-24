{ modulesPath, pkgs, config, lib, ... }:
{
  imports = [
    ../../config/minecraft/default.nix
  ];

  myConfig = {
    secrets = { };
  };
}
