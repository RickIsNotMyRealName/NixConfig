{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) lib;
  buildGo122Module = pkgs.buildGoModule.override {
    go = pkgs.unstable.go_1_22;
  };

  # Import custom nodes
  comfyuiCustomNodes = pkgs.callPackage ./comfyui/custom-nodes.nix { };

in
{
  # example = pkgs.callPackage ./example { };
  imports = [
    ./python-packages/default.nix
  ];

  lm-studio = pkgs.callPackage ./lm-studio/package.nix { };

  ollama-minicpm-v2_5 = pkgs.callPackage ./ollama-minicpm-v2_5/package.nix { buildGo122Module = buildGo122Module; };

  comfyui = pkgs.callPackage ./comfyui/package.nix {
    gpuBackend = "cuda";
    customNodes = [
      comfyuiCustomNodes.ultimate-sd-upscale
      comfyuiCustomNodes.florence2
    ];
  };
}
