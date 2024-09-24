{ modulesPath, config, pkgs, ... }:
{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    git
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPj8gjwywhMlsCqD/2v5d1ba6RbbW4QUo9sk+UkokyhW root@nixos"
    ];
  };

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  services.openssh.passwordAuthentication = true;
  
}
