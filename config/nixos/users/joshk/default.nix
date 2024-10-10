{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joshk = {
    createHome = true;
    isNormalUser = true;
    description = "Josh Krahn";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "adbusers" ];
    shell = pkgs.zsh;
    initialHashedPassword = "$y$j9T$jArB/OK7dwNWOYmxJ1Lm2/$BGA8dUMUqGp.lavPnys.JVdM.4J/7yeDdzUH4qqVw08"; # password is "test"
  };

  programs.nh = {
    enable = true;
    package = pkgs.unstable.nh;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/joshk/NixConfig/";
  };

  users.extraGroups.vboxusers.members = [ "joshk" ];

  myConfig = {
    keyFileUserName = "joshk";
  };
}
