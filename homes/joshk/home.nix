{ config, pkgs, inputs, outputs, ... }:
{

  imports = [
    ## Window Managers
    ./wm/hyprland/hyprland.nix

    ./pywal/pywal.nix

    ./waybar/waybar.nix

    ## Coding
    ./code/vscode.nix

    ## Shells
    ./shell/zsh.nix # not working

    ## Terminal
    ./terminal/alacritty.nix

    ## Fonts
    #./fonts/fonts.nix

    ## OBS Studio
    ./obs-studio/obs-studio.nix

    ## Browsers
    ./browsers/browser.nix

    ## Wallpapers
    ./theme/wallpapers.nix

    ## Git
    ./git/git.nix

    ## Script Tools
    ./script_tools/script_tools.nix

    ## Spicetify
    ./spicetify/spicetify.nix # not working

    ./psi-notify/default.nix


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
