{ config, pkgs, inputs, ... }:
{
  imports = [
    # System hyprland
    ../../config/hyprland/default.nix
  ];

  environment.systemPackages = with pkgs; [
    sddm-chili-theme
    polkit-kde-agent
    pavucontrol
    playerctl

    scrcpy

    vlc

    unstable.protonmail-desktop

    depotdownloader

    wayvnc
    remmina

    (pkgs.unstable.flameshot.override { enableWlrSupport = true; })
  ];

  services.displayManager.sddm = {
    enable = true;
    theme = "chili";
    settings = { };
  };

  services.ratbagd = {
    enable = true;
    package = pkgs.libratbag;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.light.enable = true;


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
