{ pkgs, ... }:
{
  imports = [ ];

  networking.stevenblack = {
    enable = true;
    block = [ "fakenews" "gambling" "porn" /* "social" */ ];
  };
}
