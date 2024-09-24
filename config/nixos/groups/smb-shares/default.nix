{ pkgs, ... }:
{
  myConfig = {
    secrets = {
      "smb-secrets.env" = { };
    };
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

  fileSystems."/mnt/ISOs" = {
    device = "//192.168.1.10/ISOs";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=/run/secrets/smb-secrets.env,uid=1000,gid=1000" ];
  };

  environment.systemPackages = with pkgs; [
    cifs-utils
  ];
}
