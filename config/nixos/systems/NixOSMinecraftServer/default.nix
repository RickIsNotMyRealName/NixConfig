{ pkgs, config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../config/sops/default.nix
    ../../config/cachix/default.nix
    ../../config/minecraft/default.nix
  ];

  myConfig = {
    secretsUserName = "josh_admin";
    secrets = [
      "smb-secrets.env"
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

  networking.hostName = "NixOSMinecraftServer";
  networking.nameservers = [ "192.168.1.12" ];

  boot.tmp.cleanOnBoot = true;
  nix.settings.auto-optimise-store = true;

  boot.kernelParams = [
    "console=ttyS0,115200"
    "console=tty1"
  ];

  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  users.users.root = {
    extraGroups = ["wheel" ];
    shell = pkgs.zsh;
    initialHashedPassword = "$y$j9T$jArB/OK7dwNWOYmxJ1Lm2/$BGA8dUMUqGp.lavPnys.JVdM.4J/7yeDdzUH4qqVw08"; # password is "test"
  };

  services.openssh.settings.PasswordAuthentication = true; # FIXME: Set to false
}
