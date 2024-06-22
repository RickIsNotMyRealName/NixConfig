{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) lib;
  buildGo122Module = pkgs.buildGoModule.override {
    go = pkgs.unstable.go_1_22;
  };
in
{
  # example = pkgs.callPackage ./example { };
  lm-studio = pkgs.callPackage ./lm-studio/package.nix { };
  ollama-minicpm-v2_5 = pkgs.callPackage ./ollama-minicpm-v2_5/package.nix { buildGo122Module = buildGo122Module; };
}
