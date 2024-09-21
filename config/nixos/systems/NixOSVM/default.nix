# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
  ];

  environment.systemPackages = with pkgs; [
  ];


  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # https://github.com/Mic92/nixos-shell/blob/master/README.md
  virtualisation = {
    memorySize = 4096;
    diskSize = 10 * 1024;
    cores = 6;
  };

}
