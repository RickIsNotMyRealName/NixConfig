{ modulesPath, pkgs, config, lib, ... }:
{
  imports = [
    (modulesPath + "/profiles/minimal.nix")
    ./hardware-configuration.nix
  ];

  networking.hostName = "NixOSServer";
  # networking.nameservers = [ "1.1.1.1"];

  boot.cleanTmpDir = true;
  nix.settings.auto-optimise-store = true;

  nixpkgs = {
    config = {
      cudaSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
