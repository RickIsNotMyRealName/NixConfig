# config/nixos/config/wireguard-client/default.nix
{ pkgs, inputs, config, lib, ... }:
{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  myConfig = {
    secrets = [
      "wireguard-${config.networking.hostName}-key"
      "wireguard-${config.networking.hostName}-key.pub"
    ];
  };

  networking.wireguard.interfaces = {
    wg0 = {
      privateKeyFile = "/run/secrets/wireguard-${config.networking.hostName}-key";
      listenPort = 51820;
      peers = [
        {
          publicKey = "zAwr/adosi1wxUQIsnU/hn/jRgwGcAZGZZRIRg907lc=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "tden.xyz:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
