{ pkgs, lib, config, ... }:
{
  programs.rofi = {
    enable = false;

    # Overide to use the wayland version of rofi
    package = pkgs.rofi-wayland;

    # Set terminal to the alacritty terminal emulator
    terminal = "\${pkgs.alacritty}/bin/alacritty";

    theme = import ./theme.nix {
      config = config;
      lib = lib;
      pkgs = pkgs;
    };

    # extraConfig = import ./config.nix;
  };
}
