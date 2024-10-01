{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    # ../../config/syncthing/default.nix
    ../../config/wireless/default.nix
    # ../../config/wireguard-client/default.nix
    ../../config/ollama/default.nix
    ../../config/nvidia/default.nix
  ];


  myConfig = {
    secrets = {
      "wireless.env" = { };
      "GPTV4ToolAPIKey" = { };
      "GoogleSearchAPIKey" = { };
      "OpenAIAPIKey" = { };
    };
  };


  virtualisation.virtualbox.host = {
    enable = true;
    enableKvm = true;
    enableExtensionPack = true;
    addNetworkInterface = false;
  };

  virtualisation.vmware.host.enable = true;

  networking.nameservers = [ "1.0.0.1" "1.1.1.1" ];
  # networking.nameservers = [ "192.168.1.12" ];
  # networking.wg-quick.interfaces.wg0.address = [ "10.0.0.4/32" ];

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
  services.blueman.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  hardware.nvidia.prime = {
    # Make sure to use the correct Bus ID values for your system!
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };


  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      # START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };
}
