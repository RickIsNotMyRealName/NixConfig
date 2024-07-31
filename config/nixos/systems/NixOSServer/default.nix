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

  # Enable KDE Keep here for ease just in case hyprland breaks cause of nvidia things.
  services.xserver.enable = false;
  services.xserver.desktopManager.plasma5.enable = false;
  #services.xserver.displayManager.sddm.enable = true;
}
