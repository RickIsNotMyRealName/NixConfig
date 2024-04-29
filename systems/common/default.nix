{ pkgs, config, inputs, outputs, ... }:
{
  imports = [
    # System hyprland
    ./modules/hyprland.nix
    ./modules/sops.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };



  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernelModules = [ "uinput" "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';


  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joshk = {
    isNormalUser = true;
    description = "Josh Krahn";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    shell = pkgs.zsh;
    initialHashedPassword = "$y$j9T$jArB/OK7dwNWOYmxJ1Lm2/$BGA8dUMUqGp.lavPnys.JVdM.4J/7yeDdzUH4qqVw08"; # password is "test"
  };

  virtualisation.virtualbox = {
    host.enable = true;
    # host.enableExtensionPack = true; # If the long compile times are driving you nuts comment this out
  };
  users.extraGroups.vboxusers.members = [ "joshk" ];

  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      source ${pkgs.grml-zsh-config}/etc/zsh/zshrc

      # Make user colour green in prompt instead of default blue
      zstyle ':prompt:grml:left:items:user' pre '%F{green}%B'
    '';
    promptInit = ""; # otherwise it'll override the grml prompt

    enableCompletion = true;
    autosuggestions = {
      enable = true;
    };
    syntaxHighlighting.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.light.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    plymouth
    home-manager
    sddm-chili-theme
    pavucontrol
    nixd
    nixpkgs-fmt
    # swaynotificationcenter
    kitty
    playerctl
    # sunshine
    # moonlight-qt
    kdePackages.polkit-kde-agent-1
    scrcpy

    # Archiving
    p7zip
    unrar
    unzip
    zip

    vlc

    protonmail-desktop

    gparted

    depotdownloader

    sops
    firefox

    wayvnc
    remmina

    nvd
    nix-output-monitor
  ];


  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/joshk/NixConfig";
  };

  services.sunshine = {
    enable = true;
    # autoStart = true;
  };


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
    powerline-fonts
    powerline-symbols
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
      allowedTCPPorts = [ 22 57621 5900 ];
      allowedUDPPorts = [ 22 5353 ];
    };
    stevenblack = {
      enable = true;
      block = [ "fakenews" "gambling" "porn" /* "social" */ ];
    };
  };

  services.displayManager.sddm = {
    enable = true;
    theme = "chili";
    settings = { };
  };

  security.polkit.enable = true;

  nix.settings = {
    trusted-substituters = [
      "https://ai.cachix.org"
    ];
    trusted-public-keys = [
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = " 23.11 "; # Did you read the comment?
}
