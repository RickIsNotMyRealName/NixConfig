{ pkgs, inputs, ... }:
{
  imports = [
    # "${inputs.nixpkgs-pinned}/nixos/modules/services/misc/open-webui.nix"
  ];

  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
    openFirewall = true;
    host = "0.0.0.0";
  };
}
