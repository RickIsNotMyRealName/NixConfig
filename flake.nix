{

  nixConfig = {
    extra-substituters = [
      "https://ai.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://hyprland.cachix.org"
      "https://nixpkgs-python.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
    ];
  };

  description = "My system configs flake";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-pinned = {
      url = "github:nixos/nixpkgs/398141f68ad42a51e664751e72c5972ab8d4cbfd";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    NixVirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    portainer-on-nixos = {
      url = "gitlab:cbleslie/portainer-on-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, sops-nix, spicetify-nix, NixVirt, ... }@inputs:
    let
      inherit (self) outputs;

      systems = [ "x86_64-linux" ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Create a function that takes in a hostname, a list of usernames(strings) and extraSpecialArgs and returns a nixos system configuration
      # Example usage: mkNixosSystem { hostname = "NixOSVM"; usernames = [ "joshk" "rick" ]; extraSpecialArgs = { }; }
      mkNixosSystem = { hostname, usernames, machineTypes, extraSpecialArgs ? { } }:
        let
          inherit (nixpkgs) lib pkgs;

          mkHomeUsers = usernames:
            let
              userConfig = username: ./config/home-manager/homes/${username}/home.nix;
            in
            builtins.listToAttrs (map
              (username: {
                name = username;
                value = userConfig username;
              })
              usernames);

        in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; } // extraSpecialArgs;
          modules = [
            ./config/nixos/systems/${hostname}/default.nix
            {
              networking.hostName = hostname;

              nixpkgs = {
                overlays = builtins.attrValues outputs.overlays;
                config = {
                  allowUnfree = true;
                  /* permittedInsecurePackages = [
                      "electron-25.9.0"
                  ]; */
                };
              };
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs outputs; } // extraSpecialArgs;
              home-manager.useGlobalPkgs = true;
              home-manager.users = mkHomeUsers usernames;
            }

          ] # map users and their files. Also map the machineTypes like vm, server, laptop, desktop to their respective files at 'config/nixos/systems/groups'
          ++ (map (username: ./config/nixos/users/${username}/default.nix) usernames)
          ++ (map (machineType: ./config/nixos/groups/${machineType}/default.nix) machineTypes);
        };
    in
    {
      # NixOS modules. Like nixpkgs modules.
      nixosModules = import ./modules/nixos;

      # Home Manager modules.
      homeModules = import ./modules/home-manager;

      # Custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs outputs; };

      # Custom packages. Accessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (pkgs: import ./pkgs { inherit pkgs; });

      # Dev shells
      devShell = forAllSystems (pkgs: import ./shell.nix { inherit pkgs; });

      # Formatter for nix files, available through 'nix fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      nixosConfigurations = {
        NixOSVM = mkNixosSystem {
          hostname = "NixOSVM";
          usernames = [ "joshk" ];
          extraSpecialArgs = { };
          machineTypes = [
            "common"
            "vm"
            "gui"
          ];
        };
        NixOSLaptop = mkNixosSystem {
          hostname = "NixOSLaptop";
          usernames = [ "joshk" ];
          extraSpecialArgs = { };
          machineTypes = [
            "common"
            "laptop"
            "endDevice"
            "gui"
            "smb-shares"
          ];
        };
        NixOSDesktop = mkNixosSystem {
          hostname = "NixOSDesktop";
          usernames = [ "joshk" ];
          extraSpecialArgs = { };
          machineTypes = [
            "common"
            "desktop"
            "endDevice"
            "gui"
            "smb-shares"
          ];
        };
        NixOSServer = mkNixosSystem {
          hostname = "NixOSServer";
          usernames = [ "josh_admin" ];
          extraSpecialArgs = { };
          machineTypes = [
            "common"
            "server"
            "vm"
            "smb-shares"
          ];
        };
        NixOSBaseContainer = mkNixosSystem {
          hostname = "NixOSBaseContainer";
          usernames = [ "josh_admin" ];
          extraSpecialArgs = { };
          machineTypes = [
            "common"
            "proxmox-container"
          ];
        };
        NixOSMinecraftServer = mkNixosSystem {
          hostname = "NixOSMinecraftServer";
          usernames = [ "josh_admin" ];
          extraSpecialArgs = { };
          machineTypes = [
            "common"
            "proxmox-container"
            "smb-shares"
          ];
        };

      };
    };
}
