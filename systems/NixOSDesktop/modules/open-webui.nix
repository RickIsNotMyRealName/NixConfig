{ pkgs, inputs, ... }:
{
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/open-webui.nix"
  ];

  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
    openFirewall = true;
  };
}
