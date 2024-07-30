{ pkgs, ... }:
{
  # Add all the python packages

  ultralytics = pkgs.callPackage ./ultralytics/package.nix { };
  
}
