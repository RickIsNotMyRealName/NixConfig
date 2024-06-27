{ pkgs, inputs, ... }:
{
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/open-webui.nix"
  ];

  services.open-webui = {
    enable = false;
    package = pkgs.unstable.open-webui;
    openFirewall = true;
  };
}
