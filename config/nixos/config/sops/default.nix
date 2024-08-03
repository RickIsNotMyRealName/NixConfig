{ pkgs, inputs, config, lib, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.myConfig.secretsUserName = lib.mkOption {
    type = lib.types.str;
    default = "root";
    description = "The user that owns the secrets";
  };
  options.myConfig.secrets = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "The list of secrets to be built into the runtime";
  };

  config = {
    sops = {
      defaultSopsFile = ../../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age = {
        keyFile = "/home/${config.myConfig.secretsUserName}/.config/sops/age/keys.txt";
        sshKeyPaths = [
          "/etc/ssh/ssh_host_ed25519_key"
        ];
        generateKey = true;
      };

      # Put all of config.myConfig.secretsList into sops.secrets like above
      secrets = lib.genAttrs config.myConfig.secrets (secret: {
        owner = config.myConfig.secretsUserName;
      });
    };
  };
}

      
