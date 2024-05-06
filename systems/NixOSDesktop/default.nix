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
  ];

  networking.hostName = "NixOSDesktop";

  programs.steam = {
    enable = true;
  };

  virtualisation.waydroid.enable = true;

  nixpkgs = {
    config = {
      cudaSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # AI
    lm-studio

    unstable.lutris
    unstable.winetricks
    unstable.wine
    unstable.protonup
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    environmentVariables = {
      OLLAMA_LLM_LIBRARY = "cuda_v12";
      OLLAMA_HOST = "0.0.0.0";
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          ((pkgs.OVMFFull.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd)
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
    "vfio_virqfd"
  ];

  # Enable KDE Keep here for ease just in case hyprland breaks cause of nvidia things.
  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
}
