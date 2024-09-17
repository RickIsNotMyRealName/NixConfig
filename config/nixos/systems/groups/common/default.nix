{ pkgs, lib, config, inputs, outputs, ... }:
{
  imports = [


  ] ++ (builtins.attrValues outputs.nixosModules)
  ++ (builtins.attrValues inputs.NixVirt.nixosModules);

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestions = {
      enable = true;
    };
    syntaxHighlighting.enable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = lib.mkDefault true;

  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernelModules = [ "uinput" ];


  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    plymouth
    home-manager

    nixd
    nixpkgs-fmt
    kitty

    # Archiving
    p7zip
    unrar
    unzip
    zip

    gparted

    sops

    nvd
    nix-output-monitor

    caligula
  ];

  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "632ea290851d869e"
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-emoji
    font-awesome
    font-awesome_5
    networkmanagerapplet
    fira-code
    jetbrains-mono

    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  environment = {
    shells = [ pkgs.zsh ];
    variables = {
      EDITOR = "code --wait";
      SYSTEMD_EDITOR = "code --wait";
      VISUAL = "code --wait";
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 57621 5900 15151 ];
      allowedUDPPorts = [ 22 5353 37015 37016 37017 37018 37019 37020 15151 ];
    };
    stevenblack = {
      enable = true;
      block = [ "fakenews" "gambling" "porn" /* "social" */ ];
    };
  };

  programs.command-not-found.enable = true;



  security.polkit.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = " 23.11 "; # Did you read the comment?
}
