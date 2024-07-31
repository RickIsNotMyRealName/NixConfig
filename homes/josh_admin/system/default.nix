{ pkgs, config, inputs, outputs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.josh_admin = {
    isNormalUser = true;
    description = "Josh Admin account";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    shell = pkgs.zsh;
    initialHashedPassword = "$y$j9T$jArB/OK7dwNWOYmxJ1Lm2/$BGA8dUMUqGp.lavPnys.JVdM.4J/7yeDdzUH4qqVw08"; # password is "test"
  };
}