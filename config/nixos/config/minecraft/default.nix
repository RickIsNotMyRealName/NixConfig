{ pkgs, lib, inputs, ... }:
{

  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];
  
  networking.firewall.allowedUDPPorts = [ 24454 ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      main = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_1;

        serverProperties = {
          gamemode = "survival";
          difficulty = "normal";
          simulation-distance = 10;
          level-seed = "youngadults2024";
          server-port = 25565;
        };

        whitelist = {
          YeYeGame42069 = "38e9466c-26b8-44d3-b0c1-9ad456e0a156";
        };

        symlinks = {
          mods = ./servers/main/mods;
        };
      };
    };
  };
}
