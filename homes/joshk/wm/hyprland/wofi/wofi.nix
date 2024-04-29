{ ... }:
{
  programs.wofi = {
    enable = true;

    style = import ./style.nix;
    settings = import ./settings.nix;
  };
}
