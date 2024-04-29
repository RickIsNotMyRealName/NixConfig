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
    grim
    slurp
    wl-clipboard
    wdisplays
    waybar
    swaybg
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = import ./hyprland-conf.nix { config = config; };
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };


  home.file = {
    ".config/hypr/scripts/reload.sh".source = ./scripts/reload.sh;
    ".config/hypr/scripts/launch.sh".source = ./scripts/launch.sh;
    ".config/hypr/scripts/changeWallpaper.sh".source = ./scripts/changeWallpaper.sh;
  };
}
