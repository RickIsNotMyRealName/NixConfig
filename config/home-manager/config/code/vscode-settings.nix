{
  # Allow copilot to suggest in various languages
  "github.copilot.enable"."*" = "true";
  "github.copilot.enable"."plaintext" = "true";
  "github.copilot.enable"."markdown" = "true";
  "github.copilot.enable"."cpp" = "true";
  "github.copilot.enable"."nix" = "true";

  # Format code on save
  "editor.formatOnSave" = true;

  "editor.multiCursorModifier" = "ctrlCmd";

  # Add font awesome to the font family
  "editor.fontFamily" = "'JetBrains Mono', 'Noto Sans Mono','Space Mono', 'Font Awesome 6 Free', 'Font Awesome 6 Brands', 'Font Awesome 6 Solid', 'Font Awesome 6 Regular'";
  #"editor.fontFamily" ="'Fira Code', 'Font Awesome 6 Free', 'Font Awesome 6 Brands', 'Font Awesome 6 Solid'";
  #"editor.fontFamily" =  "'Fira Code', 'Font Awesome 6 Free', 'Font Awesome 6 Brands', 'Font Awesome 6 Solid'";

  # Set auto save settings
  "files.autoSave" = "afterDelay";

  # Set theme to GitHub Dark
  "workbench.colorTheme" = "GitHub Dark";

  # Set theme to Default Dark Modern
  # "workbench.colorTheme" = "Default Dark Modern";

  # Set sidebar location to right
  "workbench.sideBar.location" = "right";

  # "diffEditor.ignoreTrimWhitespace": false
  "diffEditor.ignoreTrimWhitespace" = false;

  "colorInfo.fields" = [ "preview" ];

  # "walTheme.autoUpdate" = true;
  # "workbench.colorTheme" = "Wal";
  # "workbench.colorTheme" = "Wal Bordered";

  "vscode-color-picker.languages" = [
    ".nix"
    ".Nix"
    "nix"
    "Nix"
    "css"
    "scss"
    "less"
    "sass"
  ];


  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "nixd";
  "nix.serverSettings" = {
    # settings for 'nixd' LSP
    "nixd" = {
      "eval" = {
        "depth" = "5";
        "workers" = "5";
      };
      "formatting" = {
        "command" = "nixpkgs-fmt";
      };
      "options" = {
        "enable" = true;
        "target" = {
          # tweak arguments here
          "args" = [ ];
          # NixOS options
          "installable" = "<flakeref>#nixosConfigurations.NixOSDesktop.options";

          # Flake-parts options
          # "installable" = "<flakeref>#debug.options"

          # Home-manager options
          #"installable" = "<flakeref>#homeConfigurations.joshk.options"
        };
      };
    };
  };
  "nix.formatterPath" = "nixpkgs-fmt";

  "git.autofetch" = true;

  "cSpell.userWords" = [
    "hyprland"
    "nixpkgs"
    "nixos"
    "cachix"
  ];

  "debug.onTaskErrors" = "abort";
}

