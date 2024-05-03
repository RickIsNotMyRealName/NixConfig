{ pkgs, ... }:
{
  virtualisation.libvirt = {
    enable = true;
    swtpm.enable = true;
    connections."qemu:///system" = {
    };
  };
}

