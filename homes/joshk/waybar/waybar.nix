{ pkgs, config, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;

    style = import ./waybar-style.nix {
      config = config;
    };

    settings = import ./waybar-settings.nix {
      config = config;
    };
  };
}
