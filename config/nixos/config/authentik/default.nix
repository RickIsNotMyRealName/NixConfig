{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    authentik
  ];
}
