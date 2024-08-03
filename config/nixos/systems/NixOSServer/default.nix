{ modulesPath, pkgs, config, lib, ... }:
{
  imports = [
    # Use `profiles/minimal.nix` as the base configuration of this system but override `environment.noXlibs` to `false`.
    (modulesPath + "/profiles/minimal.nix") { environment.noXlibs = false; }
    ./hardware-configuration.nix

    # Traefik
    ../../config/traefik/default.nix
    ../../config/sops/default.nix
  ];

  myConfig = {
    secretsUserName = "josh_admin";
    secrets = [
      "smb-secrets.env"
    ];
  };

  networking.hostName = "NixOSServer";
  # networking.nameservers = [ "1.1.1.1"];

  boot.tmp.cleanOnBoot = true;
  nix.settings.auto-optimise-store = true;

  nixpkgs = {
    config = {
      cudaSupport = true;
    };
  };

  boot.kernelParams = [
    "console=ttyS0,115200"
    "console=tty1"
  ];

  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;


  services.openssh.passwordAuthentication = true; # FIXME: Set to false
}
