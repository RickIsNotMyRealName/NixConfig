{ config, pkgs, ... }:
{
  programs.obs-studio = {
    enable = false;
    plugins = [
      # pkgs.obs-studio-plugins.obs-backgroundremoval
      # pkgs.obs-studio-plugins.obs-source-record
      # pkgs.obs-studio-plugins.input-overlay
    ];
  };
}
