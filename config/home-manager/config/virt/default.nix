{ pkgs, ... }:
{
  virtualisation.libvirt = {
    enable = true;
    swtpm.enable = true;
    connections."qemu:///system" = {
      domains = [
        {
          definition = ./domains/win10.xml;
          active = false;
        }
      ];
      networks = [
        {
          definition = ./networks/default.xml;
          active = true;
        }
      ];
      pools = [
        {
          definition = ./pools/images.xml;
          active = true;
          volumes = [
            {
              present = true;
              definition = ./volumes/win10.img.xml;
              name = "win10.img";
            }
          ];
        }
        {
          definition = ./pools/isos.xml;
          active = true;
          volumes = [ ];
        }
      ];
    };
  };
}

