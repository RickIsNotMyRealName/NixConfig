{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) lib;
in
{
  # example = pkgs.callPackage ./example { };
  lm-studio = pkgs.callPackage ./lm-studio/lm-studio.nix { };
}
