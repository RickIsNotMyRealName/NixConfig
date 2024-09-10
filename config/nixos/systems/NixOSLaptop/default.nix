{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    # ../../config/syncthing/default.nix
    ../../config/wireless/default.nix
    ../../config/sops/default.nix
    ../../config/cachix/default.nix
  ];


  myConfig = {
    secretsUserName = "joshk";
    secrets = [
      "wireless.env"
      "GPTV4ToolAPIKey"
      "GoogleSearchAPIKey"
      "OpenAIAPIKey"
      "smb-secrets.env"
    ];
  };


  virtualisation.virtualbox.host = {
    enable = true;
    enableKvm = true;
    enableExtensionPack = true;
    addNetworkInterface = false;
  };

  virtualisation.vmware.host.enable = true;


  # Set the hostname of my system.
  networking.hostName = "NixOSLaptop";

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
  services.blueman.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

}
