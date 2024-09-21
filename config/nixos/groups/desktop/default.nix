{ pkgs, ... }:
{
  imports = [ ];

  networking.stevenblack = {
    enable = true;
    block = [ "fakenews" "gambling" "porn" /* "social" */ ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-emoji
    font-awesome
    font-awesome_5
    networkmanagerapplet
    fira-code
    jetbrains-mono

    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
