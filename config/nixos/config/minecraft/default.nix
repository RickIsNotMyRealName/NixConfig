{ pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  networking.firewall.allowedUDPPorts = [ 24454 19132 ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      main = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_1;
        enableReload = true;
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
          "config/Geyser-Fabric/config.yml" = ./servers/main/config/Geyser-Fabric/config.yml;
          "config/ping-wheel.server.json" = ./servers/main/config/ping-wheel.server.json;
          "config/voicechat/voicechat-server.properties" = ./servers/main/config/voicechat/voicechat-server.properties;
        };

        files = {
          "config/fallingtree.json" = ./servers/main/config/fallingtree.json;
        };

      };
    };
  };
}
