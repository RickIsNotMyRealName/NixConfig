{ ... }:
{
  programs.oh-my-posh = {
    enable = true;
    useTheme = "agnoster.minimal";
    enableZshIntegration = true;
    settings = import ./settings.nix;
  };

}
