{ modulesPath, config, pkgs, ... }:
{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    git
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJX/6PTPe8gVtAlWQcO7GUvb/AWa4N9GrG21xk2mSfEc joshk@NixOSDesktop"
    ];
  };

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  services.openssh.passwordAuthentication = true;

}
