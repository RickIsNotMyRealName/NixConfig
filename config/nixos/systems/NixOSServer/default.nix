{ pkgs, config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "NixOSServer";
  # networking.nameservers = [ "1.1.1.1"];

  nixpkgs = {
    config = {
      cudaSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [

  ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
