{ home, pkgs, ... }:
{
  programs.pywal.enable = true;


  home.file = {
    ".config/wal/templates/colors-hyprland.conf".source = ./templates/colors-hyprland.conf;
    ".config/wal/templates/colors-rofi-dark.rasi".source = ./templates/colors-rofi-dark.rasi;
    ".config/wal/templates/colors-rofi-light.rasi".source = ./templates/colors-rofi-light.rasi;
  };
}
