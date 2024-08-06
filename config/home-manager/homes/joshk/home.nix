{ config, pkgs, inputs, outputs, ... }:
{

  imports = [
    ## Window Managers
    ../../config/wm/hyprland/hyprland.nix

    ../../config/pywal/pywal.nix

    ../../config/waybar/waybar.nix

    ## Coding
    ../../config/code/vscode.nix

    ## Shells
    ../../config/shell/zsh.nix # not working

    ## Terminal
    ../../config/terminal/alacritty.nix

    ## Fonts
    #../../config/fonts/fonts.nix

    ## OBS Studio
    ../../config/obs-studio/obs-studio.nix

    ## Browsers
    ../../config/browsers/browser.nix

    ## Wallpapers
    ../../config/theme/wallpapers.nix

    ## Git
    ../../config/git/git.nix

    ## Script Tools
    ../../config/script_tools/script_tools.nix

    ## Spicetify
    ../../config/spicetify/spicetify.nix # not working

    ../../config/psi-notify/default.nix

    # ../../config/virt/default.nix

    ../../config/mangohud/default.nix

    ../../config/apex-config/default.nix

    # zoxide
    ../../config/zoxide/default.nix

  ] ++ (builtins.attrValues outputs.homeModules)
  ++ (builtins.attrValues inputs.NixVirt.homeModules);

  home = {
    username = "joshk";
    homeDirectory = "/home/joshk";

    packages = with pkgs; [
      micro
      zsh
      thefuck
      calibre
      prismlauncher
      obsidian
      discord
      bibletime
      kcalc
      protonvpn-gui
      neofetch
      nwg-wrapper
      git
      tree
      nixpkgs-fmt
      lf
      feh
      libnotify
      # gpt4all # FIXME decide if i want this installed or not.
      piper
      qjackctl
      gimp
      heroic
    ];

    sessionVariables = {
      EDITOR = "code --wait";
      SYSTEMD_EDITOR = "code --wait";
      VISUAL = "code --wait";
    };

    stateVersion = "23.11"; # Please read the comment before changing.
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
