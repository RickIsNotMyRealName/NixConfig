{ pkgs, ... }:
{
  systemPackages = with pkgs; [
    authentik
  ];
}
