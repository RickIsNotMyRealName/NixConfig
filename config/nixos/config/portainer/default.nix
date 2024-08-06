{ inputs, ... }:
{
  imports = [
    inputs.portainer-on-nixos.nixosModules.portainer
  ];

  services.portainer = {
    enable = true;
    port = 9443;
    openFirewall = true;
  };
}
