{ pkgs, inputs, config, lib, ... }:

let
  cfg = config.myConfig;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  # Define the user who owns the keyfile, defaulting to "root"
  options.myConfig.keyFileUserName = lib.mkOption {
    type = lib.types.str;
    default = "root"; # Added a default value
    description = "The user who has the keyfile that can decrypt the secrets when building the system.";
  };

  # Define the secrets as an attribute set with sub-options
  options.myConfig.secrets = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        owner = lib.mkOption {
          type = lib.types.str;
          default = cfg.keyFileUserName;
          description = "The user that owns the secret.";
        };
        path = lib.mkOption {
          type = lib.types.str;
          default = "/run/secrets";
          description = "The folder where the secret will be stored.";
        };
      };
    });
    default = { };
    description = "An attribute set of secrets with their properties like owner and folder.";
  };

  config = {
    sops = {
      defaultSopsFile = ../../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age = {
        keyFile = "/home/${cfg.keyFileUserName}/.config/sops/age/keys.txt";
        sshKeyPaths = [
          "/etc/ssh/ssh_host_ed25519_key"
        ];
        generateKey = true;
      };

      # Use lib.mapAttrs to correctly transform the attribute set
      secrets = lib.mapAttrs
        (secretName: secretConfig: {
          owner = secretConfig.owner or cfg.keyFileUserName;
          path = "${secretConfig.path or "/run/secrets"}/${secretName}";
        })
        cfg.secrets;
    };
  };
}
