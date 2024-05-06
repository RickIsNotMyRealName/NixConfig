# ./mangohud/default.nix
{ pkgs, ... }:
{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };
}
