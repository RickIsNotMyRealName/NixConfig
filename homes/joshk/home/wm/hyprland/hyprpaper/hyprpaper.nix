{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file = {
    ".config/hypr/hyprpaper.conf" = ./hyprpaper.conf;
  };
}
