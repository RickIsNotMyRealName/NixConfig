{ pkgs, config, lib, ... }:
let
  gpuIDs3060 = [
    "10de:2504" # Graphics
    "10de:228e" # Audio
  ];
  gpuIDs960 = [
    "10de:1401" # Graphics
    "10de:0fba" # Audio
    "8086:2723" # Wireless
  ];
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/syncthing.nix
    ./modules/nvidia.nix
    ./modules/open-webui.nix
    ./modules/comfyui-container.nix
  ];

  networking.hostName = "NixOSDesktop";
  networking.nameservers = [ "1.1.1.1"];

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
    lm-studio
    # comfyui

    unstable.lutris
    unstable.winetricks
    unstable.wine
    unstable.protonup

    unstable.gamescope
    unstable.local-ai
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama;
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
  ] ++ [ "vfio-pci.ids=${lib.concatStringsSep "," gpuIDs960}" ];

  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  # Enable KDE Keep here for ease just in case hyprland breaks cause of nvidia things.
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
}
