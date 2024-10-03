# config/home-manager/config/wm/hyprland/rofi/theme.nix
{ config, lib, pkgs, ... }:

let
  # Import the mkLiteral function to handle literal values in Rasi
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  "*" = { };

  window = {
    border-color = mkLiteral "@normal-foreground";
    border = mkLiteral "2px solid";
    border-radius = mkLiteral "10px";

    width = mkLiteral "30%";
    padding = mkLiteral "10px";
  };

  mainbox = {
    padding = mkLiteral "0px";
  };

  inputbar = {
    border = mkLiteral "2px solid";
    border-color = mkLiteral "@normal-foreground";
    border-radius = mkLiteral "10px";
    padding = mkLiteral "10px";
    margin = mkLiteral "5px";
  };

  listview = {
    spaceing = mkLiteral "10px";

    background-color = mkLiteral "@normal-background";
    border = mkLiteral "2px solid";
    border-color = mkLiteral "@normal-foreground";
    border-radius = mkLiteral "10px";

    margin = mkLiteral "5px";
    padding = mkLiteral "7px";
    dynamic = mkLiteral "false";
  };

  element = {
    border-radius = mkLiteral "5px";
    margin = mkLiteral "1px";
  };

  element-icon = {
    border-radius = mkLiteral "10px";
    margin-right = mkLiteral "10px";
    size = mkLiteral "24px";
  };
}
