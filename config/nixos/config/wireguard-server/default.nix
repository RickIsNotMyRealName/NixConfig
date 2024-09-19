{ pkgs, ... }:
{
  imports = [
    ../../config/sops/default.nix
  ];

  myConfig = {
    secrets = [
      "wireguard-server-key"
      "wireguard-server-key.pub"
    ];
  };

  networking.nat = {
    enable = true;
    internalInterfaces = [ "wg0" ];
    externalInterface = "enp6s18";
  };

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 51820 ];
  };

  # Enable WireGuard and configure the interface
  networking.wireguard = {
    enable = true;
    interfaces = {
      wg0 = {
        ips = [ "10.0.0.1/24" ]; # VPN server's IP in the VPN network
        privateKeyFile = "/run/secrets/wireguard-server-key"; # Path to the server's private key
        listenPort = 51820;

        peers = [
          {
            publicKey = "bAtOGoLZX57W/ggInQL7d61v07beLNUYeXSYLbJ5oS0=";
            allowedIPs = [ "10.0.0.2/32" ];
          }
        ];
      };
    };
  };
}
