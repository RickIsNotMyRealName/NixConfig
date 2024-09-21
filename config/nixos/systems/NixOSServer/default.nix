{ modulesPath, pkgs, config, lib, ... }:
{
  imports = [
    # Use `profiles/minimal.nix` as the base configuration of this system but override `environment.noXlibs` to `false`.
    (modulesPath + "/profiles/minimal.nix")
    { environment.noXlibs = false; }
    ./hardware-configuration.nix

    # Traefik
    ../../config/traefik/default.nix
    ../../config/wireguard-server/default.nix
  ];

  myConfig = {
    secrets = [
      "traefik.env"
    ];
  };

  

  networking.hostName = "NixOSServer";
  networking.nameservers = [ "192.168.1.12" ];

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


  services.openssh.settings.PasswordAuthentication = true; # FIXME: Set to false
}
