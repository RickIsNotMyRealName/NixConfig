{ config, pkgs, inputs, outputs, ... }:
{

  imports = [
    ## Shells
    ../../config/shells/zsh.nix

    ## Terminal
    ../../config/terminal/alacritty.nix


    ## Git
    ../../config/git/git.nix




  ] ++ (builtins.attrValues outputs.homeModules)
  ++ (builtins.attrValues inputs.NixVirt.homeModules);

  home = {
    username = "josh_admin";
    homeDirectory = "/home/josh_admin";

    packages = with pkgs; [ ];

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
