{ pkgs, lib, config, ... }:
{
  programs.rofi = {
    enable = true;

    # Override to use the Wayland version of Rofi
    package = pkgs.rofi-wayland;

    # Set terminal to the Alacritty terminal emulator
    terminal = "${pkgs.alacritty}/bin/alacritty";

    theme = import ./theme.nix {
      config = config;
      lib = lib;
      pkgs = pkgs;
    };

    plugins = with pkgs; [
      rofi-systemd
    ];

    location = "center";

    extraConfig = {
      prompt = "Run:";
      modi = "drun,window,run,ssh,keys,filebrowser";
      
      markup = true;
      case-insensitive = true;
      matcher = "fuzzy";
      sort = true;

      # Key Bindings
      "kb-accept-entry" = "Return";
      "kb-cancel" = "Escape";
      "kb-row-up" = "Up";
      "kb-row-down" = "Down";
      "kb-switch-mode" = "Tab";
    };
  };
}
