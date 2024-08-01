{ modulesPath, pkgs, config, lib, ... }:
{
  imports = [
    # Use `profiles/minimal.nix` as the base configuration of this system but override `environment.noXlibs` to `false`.
    (modulesPath + "/profiles/minimal.nix") { environment.noXlibs = false; }
    ./hardware-configuration.nix
  ];

  networking.hostName = "NixOSServer";
  # networking.nameservers = [ "1.1.1.1"];

  boot.tmp.cleanOnBoot = true;
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
