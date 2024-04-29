{ pkgs }:
with pkgs.vscode-extensions; [
  ms-vscode.cpptools
  jnoortheen.nix-ide
  foxundermoon.shell-format
] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  # github.copilot
  {
    name = "copilot";
    publisher = "github";
    version = "1.172.755";
    sha256 = "sha256-4sIg7RXaXM24hXRf5Hrq4gZJ/apMldP9SmT2oWz3yX8=";
  }
  # bierner.color-info
  {
    name = "color-info";
    publisher = "bierner";
    version = "0.1.0";
    sha256 = "sha256-9H/f3A3DdVut/z+LxhomXXnP2Qo5fGpwvRHPAwnGk3Q=";
  }
  # markosth09.color-picker
  {
    name = "color-picker";
    publisher = "markosth09";
    version = "1.0.0";
    sha256 = "sha256-28tSGWdtQVu0I34DQBl1CicEqQHP37dS//FH9sTaECY=";
  }
  # dlasagno.wal-theme
  {
    name = "wal-theme";
    publisher = "dlasagno";
    version = "1.2.0";
    sha256 = "sha256-X16N5ClNVLtWST64ybJUEIRo6WgDCzODhBA9ScAHI5w=";
  }
  # bbenoist.nix
  {
    name = "nix";
    publisher = "bbenoist";
    version = "1.0.1";
    sha256 = "sha256-qwxqOGublQeVP2qrLF94ndX/Be9oZOn+ZMCFX1yyoH0=";
  }
  # DavidAnson.vscode-markdownlint
  {
    name = "vscode-markdownlint";
    publisher = "DavidAnson";
    version = "0.54.0";
    sha256 = "sha256-G1vp+j9qk3O18XXy/ujNK0Smj9K8betq5kiGnqVe0DQ=";
  }
  # yzhang.markdown-all-in-one
  {
    name = "markdown-all-in-one";
    publisher = "yzhang";
    version = "3.6.2";
    sha256 = "sha256-BIbgUkIuy8clq4G4x1Zd08M8k4u5ZPe80+z6fSAeLdk=";
  }
  # eww-yuck.yuck
  {
    name = "yuck";
    publisher = "eww-yuck";
    version = "0.0.3";
    sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
  }
  # streetsidesoftware.code-spell-checker
  {
    name = "code-spell-checker";
    publisher = "streetsidesoftware";
    version = "3.0.1";
    sha256 = "sha256-KeYE6/yO2n3RHPjnJOnOyHsz4XW81y9AbkSC/I975kQ=";
  }
  # ms-vscode.cpptools-extension-pack
  {
    name = "cpptools-extension-pack";
    publisher = "ms-vscode";
    version = "1.2.0";
    sha256 = "sha256-MEWL5ZlEfKPPR7wrejln+X5CIy4LcF+LIqFZYmlosZQ=";
  }
  # arrterian.nix-env-selector
  {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "0.0.1";
    sha256 = "sha256-REeBrJymLQB93WNIQ+QG4x2Pa+d8dPVQVY3V9wmjPsI=";
  }
  # ms-vscode.cmake-tools
  {
    name = "cmake-tools";
    publisher = "ms-vscode";
    version = "1.7.0";
    sha256 = "sha256-+fzs99zorNqGEi+oXYX37MocMZwB++lLbeEUWJ5cGME=";
  }
  # twxs.cmake
  {
    name = "cmake";
    publisher = "twxs";
    version = "0.0.17";
    sha256 = "sha256-CFiva1AO/oHpszbpd7lLtDzbv1Yi55yQOQPP/kCTH4Y=";
  }
  # moshfeu.compare-folders
  {
    name = "compare-folders";
    publisher = "moshfeu";
    version = "0.24.3";
    sha256 = "sha256-eaumF2BIqEYoyL7LQ0Wx3+gkkFGpWKQoN3AisI8wTQY=";
  }

]
