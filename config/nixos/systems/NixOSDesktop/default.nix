{ pkgs, config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix

    # ../../config/syncthing/default.nix
    ../../config/nvidia/default.nix
    ../../config/open-webui/default.nix
    ../../config/comfyui/default.nix
    ../../config/sops/default.nix
    # ../../config/autologin-joshk/default.nix
    ../../config/cachix/default.nix
    ../../config/wireguard-client/default.nix
  ];


  myConfig = {
    secrets = [
      "wireless.env"
      "GPTV4ToolAPIKey"
      "GoogleSearchAPIKey"
      "OpenAIAPIKey"
      "smb-secrets.env"
    ];
  };

  networking.hostName = "NixOSDesktop";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  # networking.nameservers = [ "192.168.1.12" ];
  networking.wg-quick.interfaces.wg0.address = [ "10.0.0.3/32" ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman = {
    enable = true;
  };

  hardware.xpadneo.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamescope.enable = true;

  virtualisation.waydroid.enable = true;

  nixpkgs = {
    config = {
      cudaSupport = true;
      packageOverrides = pkgs: {
        steam = pkgs.steam.override {
          extraPkgs = pkgs: with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
          ];
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # AI
    # lm-studio
    # comfyui

    # Packet Tracer
    # ciscoPacketTracer8

    unstable.lutris
    unstable.winetricks
    unstable.wine
    unstable.protonup

    unstable.gamescope
    unstable.local-ai

    cifs-utils

    remmina
  ];

  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    acceleration = "cuda";
    environmentVariables = {
      # OLLAMA_LLM_LIBRARY = "cuda_v12";
      OLLAMA_CUDA_LIBRARY = "cuda_v11";
      OLLAMA_HOST = "0.0.0.0";
    };
    listenAddress = "0.0.0.0:11434";
  };
  # Open port 11434
  networking.firewall.allowedTCPPorts = [ 11434 ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (
            (pkgs.OVMFFull.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          )
        ];
      };
    };
  };

  programs.virt-manager.enable = true;
  users.users.joshk.extraGroups = [ "libvirt" "libvirtd" "kvm" ];
  boot.kernelParams = [
    "intel_iommu=on"
    "vfio_iommu_type1.allow_unsafe_interrupts=1"
    "kvm.ignore_msrs=1"
    "preempt=voluntary"
  ];

  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  programs.adb.enable = true;

  virtualisation.virtualbox = {
    host.enable = true;
    # host.enableExtensionPack = true; # If the long compile times are driving you nuts comment this out
  };

  # Auto mount smb://192.168.1.10/NixConfig
  # Mount it so any user can access it
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

  # Enable KDE Keep here for ease just in case hyprland breaks cause of nvidia things.
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
}
