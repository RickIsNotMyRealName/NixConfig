{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles."jkrahn" = { };
  };
}
