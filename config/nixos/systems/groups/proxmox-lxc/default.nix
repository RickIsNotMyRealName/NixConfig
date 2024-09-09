{ modulesPath, lib, ... }:
{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.initrd.systemd.enable = lib.mkForce false;

  proxmoxLXC = {
    enable = true;
    manageNetwork = false;
    manageHostName = false;
  };

}
