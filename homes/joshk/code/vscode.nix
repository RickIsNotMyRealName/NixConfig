{ config, pkgs, ... }:
{
  # allow unfree
  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    mutableExtensionsDir = false;
    extensions = import ./vscode-extensions.nix { pkgs = pkgs; };
    userSettings = import ./vscode-settings.nix;

  };

  home.packages = with pkgs; [
    # Debugging
    gdb

  ];
}
