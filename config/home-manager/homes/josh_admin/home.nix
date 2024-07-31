{ config, pkgs, inputs, outputs, ... }:
{

  imports = [

  ] ++ (builtins.attrValues outputs.homeModules)
  ++ (builtins.attrValues inputs.NixVirt.homeModules);

  home = {
    username = "josh_admin";
    homeDirectory = "/home/josh_admin";

    packages = with pkgs; [
      micro
      zsh
      neofetch
      git
      tree
      nixpkgs-fmt
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
