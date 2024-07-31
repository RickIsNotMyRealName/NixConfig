{ pkgs, lib, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.josh_admin = {
    isNormalUser = true;
    description = "josh_admin";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "adbusers" ];
    shell = pkgs.zsh;
    initialHashedPassword = "$y$j9T$jArB/OK7dwNWOYmxJ1Lm2/$BGA8dUMUqGp.lavPnys.JVdM.4J/7yeDdzUH4qqVw08"; # password is "test"
  };

  programs.nh = {
    enable = lib.mkDefault true;
    package = lib.mkDefault pkgs.unstable.nh;
    clean.enable = lib.mkDefault true;
    clean.extraArgs = lib.mkDefault "--keep-since 4d --keep 3";
    flake = lib.mkDefault "/home/josh_admin/NixConfig";

  };
}
