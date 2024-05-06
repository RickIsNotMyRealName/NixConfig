# ./mangohud/default.nix
# You can test the config without a game running using the mesa-demos package
#   Like v
{ pkgs, ... }:
{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = import ./config.nix;
    settingsPerApplication = {
      # "steam" = ./steam.nix; # FIXME ? is this right idk
    };
  };
}
