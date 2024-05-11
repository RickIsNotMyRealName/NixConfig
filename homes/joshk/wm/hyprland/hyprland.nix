# hyprland.nix

{ lib, pkgs, config, inputs, ... }:
{
  imports = [
    # Hyprlock
    ./hyprlock/hyprlock.nix

    # SwayNC
    ./swaync/swaync.nix

    ./wofi/wofi.nix

    ./rofi/rofi.nix

    ./eww/eww.nix
  ];


  home.packages = with pkgs; [
    wayland
    xdg-utils
    glib
    dracula-theme
    gnome3.adwaita-icon-theme    
    wdisplays
    swaybg

    # Screenshots
    grim
    slurp
    wl-clipboard
    imagemagick
    feh # For displaying images 
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = import ./hyprland-conf.nix { config = config; pkgs = pkgs; };
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };


  home.file = {
    ".config/hypr/scripts/reload.sh".source = ./scripts/reload.sh;
    ".config/hypr/scripts/launch.sh".source = ./scripts/launch.sh;
    ".config/hypr/scripts/changeWallpaper.sh".source = ./scripts/changeWallpaper.sh;
    ".config/hypr/scripts/screenshot.sh".source = ./scripts/screenshot.sh;
  };
}
