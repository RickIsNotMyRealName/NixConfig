{ pkgs, inputs, config, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age =
      {
        keyFile = "/home/joshk/.config/sops/age/keys.txt";
        sshKeyPaths = [
          "/etc/ssh/ssh_host_ed25519_key"
        ];
        generateKey = true;
      };


    secrets = {
      "wireless.env" = {
        owner = config.users.users.joshk.name;
      };
      "GPTV4ToolAPIKey" = {
        owner = config.users.users.joshk.name;
      };
      "GoogleSearchAPIKey" = {
        owner = config.users.users.joshk.name;
      };
      "OpenAIAPIKey" = {
        owner = config.users.users.joshk.name;
      };
    };
  };
}
