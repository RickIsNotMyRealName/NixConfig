{ modulesPath, config, pkgs, ... }:
{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    git
  ];
}
