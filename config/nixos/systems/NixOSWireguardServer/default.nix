{ modulesPath, pkgs, config, lib, ... }:
{
  imports = [
    ../../config/wireguard-server/default.nix
  ];
}
