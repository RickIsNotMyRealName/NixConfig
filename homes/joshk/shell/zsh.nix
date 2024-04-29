{ config, pkgs, ... }:
{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;

    # Aliases 
    shellAliases = {
      cll = "clear && ls -l";
    };
  };
}
