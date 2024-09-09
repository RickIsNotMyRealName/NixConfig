{ modulesPath, lib, ... }:
{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  boot.loader.systemd-boot.enable = false;

  proxmoxLXC = {
    enable = true;
    manageNetwork = false;
    manageHostName = false;
  };

}
