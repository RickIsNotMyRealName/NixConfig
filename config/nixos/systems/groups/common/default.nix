{ pkgs, config, inputs, outputs, ... }:
{
  imports = [
    # System hyprland
    ../../../config/hyprland/default.nix
    ../../../config/sops/default.nix

  ] ++ (builtins.attrValues outputs.nixosModules)
  ++ (builtins.attrValues inputs.NixVirt.nixosModules);

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';
  };

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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernelModules = [ "uinput" ];


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
    kitty
    playerctl
    # sunshine
    # moonlight-qt
    polkit-kde-agent
    scrcpy

    # Archiving
    p7zip
    unrar
    unzip
    zip

    vlc

    unstable.protonmail-desktop

    gparted

    depotdownloader

    sops

    wayvnc
    remmina

    nvd
    nix-output-monitor

    caligula

    (flameshot.overrideAttrs (oldAttrs: {
      src = fetchFromGitHub {
        owner = "flameshot-org";
        repo = "flameshot";
        rev = "master";
        sha256 = "sha256-Y9RnVxic5mlRIc48wYVQXrvu/s65smtMMVj8HBskHzE=";
      };
      cmakeFlags = [ "-DUSE_WAYLAND_GRIM=ON" ];
    }))
  ];




  # services.sunshine = {
  #   enable = true;
  #   # autoStart = true;
  # };


  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "632ea290851d869e"
    ];
  };

  services.ratbagd = {
    enable = true;
    # package = pkgs.libratbag;
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
      allowedTCPPorts = [ 22 57621 5900 15151 ];
      allowedUDPPorts = [ 22 5353 37015 37016 37017 37018 37019 37020 15151 ];
    };
    stevenblack = {
      enable = true;
      block = [ "fakenews" "gambling" "porn" /* "social" */ ];
    };
  };

  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "chili";
    settings = { };
  };

  security.polkit.enable = true;

  nix.settings = {
    substituters = [
      "https://ai.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://hyprland.cachix.org"
      "https://nixpkgs-python.cachix.org"
    ];
    trusted-public-keys = [
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
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