{ pkgs, inputs, ... }:
{
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/open-webui.nix"
  ];

  services.open-webui = {
    enable = true;
    package = pkgs.pinned.open-webui;
    openFirewall = true;
    host = "0.0.0.0";
  };
}
