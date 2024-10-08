{ modulesPath, pkgs, config, lib, ... }:
{
  imports = [
    # Use `profiles/minimal.nix` as the base configuration of this system but override `environment.noXlibs` to `false`.
    (modulesPath + "/profiles/minimal.nix")
    { environment.noXlibs = false; }
    ./hardware-configuration.nix
  ];

  networking.nameservers = [ "192.168.1.12" ];

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


  services.openssh.settings.PasswordAuthentication = true; # FIXME: Set to false
}
