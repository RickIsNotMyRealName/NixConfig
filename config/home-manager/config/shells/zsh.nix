{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    grml-zsh-config
  ];

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

    initExtra = ''
      # grml-zsh-config
      source ${pkgs.grml-zsh-config}/etc/zsh/zshrc

      # Make user colour green in prompt instead of default blue
      zstyle ':prompt:grml:left:items:user' pre '%F{green}%B'
    '';
  };
}
