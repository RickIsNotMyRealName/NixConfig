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
    externalInterface = "eth0";
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

        # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
        # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
        '';

        # This undoes the above command
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
        '';

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
