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
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
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
  };

  outputs = { self, nixpkgs, home-manager, hyprland, sops-nix, spicetify-nix, NixVirt, ... }@inputs:
    let
      inherit (self) outputs;

      systems = [ "x86_64-linux" ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Create a function that takes in a hostname, a list of usernames(strings) and extraSpecialArgs and returns a nixos system configuration
      # Example usage: mkNixosSystem { hostname = "NixOSVM"; usernames = [ "joshk" "rick" ]; extraSpecialArgs = { }; }
      mkNixosSystem = { hostname, usernames, extraSpecialArgs ? { } }:
        let
          inherit (nixpkgs) lib pkgs;

          # Define a function to generate user configurations
          mkUsers = usernames:
            let
              userConfig = username: ./homes/${username}/home.nix;
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
            ./systems/${hostname}/default.nix
            ./systems/common/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs outputs; } // extraSpecialArgs;
              home-manager.useGlobalPkgs = true;
              home-manager.users = mkUsers usernames;
            }
          ];
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
        };
        NixOSLaptop = mkNixosSystem {
          hostname = "NixOSLaptop";
          usernames = [ "joshk" ];
          extraSpecialArgs = { };
        };
        NixOSDesktop = mkNixosSystem {
          hostname = "NixOSDesktop";
          usernames = [ "joshk" ];
          extraSpecialArgs = { };
        };
      };
    };
}


