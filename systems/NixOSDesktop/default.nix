{ pkgs, config, ... }:
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
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    environmentVariables = {
      OLLAMA_LLM_LIBRARY = "cuda_v12";
      OLLAMA_HOST = "0.0.0.0";
    };
  };



  # Enable KDE Keep here for ease just in case hyprland breaks cause of nvidia things.
  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
}
