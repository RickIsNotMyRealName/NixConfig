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
      "wireguard-server-key.pub"
    ];
  };

  networking.wg-quick = {
    interfaces = {
      wg0 = {
        privateKeyFile = "/run/secrets/wireguard-${config.networking.hostName}-key";
        autostart = true;
        dns = [ "192.168.1.12" "1.0.0.1" "1.1.1.1" ];
        peers = [{
          publicKey = "zAwr/adosi1wxUQIsnU/hn/jRgwGcAZGZZRIRg907lc=";
          allowedIPs = [ "0.0.0.0/0" "192.168.1.0/24"];
          endpoint = "tden.xyz:51820";
          persistentKeepalive = 25;
        }];
      };
    };
  };
}
