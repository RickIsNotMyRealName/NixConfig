{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./wireless.nix
    ./syncthing.nix
  ];


  # Set the hostname of my system.
  networking.hostName = "NixOSLaptop";

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

}
