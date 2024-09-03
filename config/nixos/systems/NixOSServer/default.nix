{ modulesPath, pkgs, config, lib, ... }:
{
  imports = [
    # Use `profiles/minimal.nix` as the base configuration of this system but override `environment.noXlibs` to `false`.
    (modulesPath + "/profiles/minimal.nix")
    { environment.noXlibs = false; }
    ./hardware-configuration.nix

    # Traefik
    ../../config/traefik/default.nix
    ../../config/sops/default.nix
    # ../../config/portainer/default.nix
  ];

  myConfig = {
    secretsUserName = "josh_admin";
    secrets = [
      "smb-secrets.env"
      "traefik.env"
    ];
  };

  fileSystems."/mnt/NixConfig" = {
    device = "//192.168.1.10/NixConfig";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=/run/secrets/smb-secrets.env,uid=1000,gid=1000" ];
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
    authentik
  ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;


  services.openssh.passwordAuthentication = true; # FIXME: Set to false
}
