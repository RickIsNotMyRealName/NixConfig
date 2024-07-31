{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.hyprlock
  ];


  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;


}
