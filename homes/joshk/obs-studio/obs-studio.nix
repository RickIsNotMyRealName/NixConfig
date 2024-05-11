{ config, pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = pkgs.unstable.obs-studio;
    plugins = [
      pkgs.unstable.obs-studio-plugins.obs-backgroundremoval
      pkgs.unstable.obs-studio-plugins.obs-source-record
      pkgs.unstable.obs-studio-plugins.input-overlay
      pkgs.unstable.obs-studio-plugins.obs-vkcapture
    ];
  };
}
