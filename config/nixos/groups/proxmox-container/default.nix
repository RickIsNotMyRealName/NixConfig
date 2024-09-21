{ modulesPath, lib, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/proxmox-lxc.nix
    "${modulesPath}/virtualisation/proxmox-lxc.nix"
  ];

  proxmoxLXC = {
    enable = true;
    privileged = false;
    manageNetwork = false;
    manageHostName = false;
  };

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.initrd.systemd.enable = lib.mkForce false;
}
