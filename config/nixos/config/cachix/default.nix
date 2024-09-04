{ ... }:
{
  nix.settings = {
    substituters = [
      "https://ai.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://hyprland.cachix.org"
      "https://nixpkgs-python.cachix.org"
      "https://rickisnotmyrealname.cachix.org"
    ];
    trusted-public-keys = [
      "rickisnotmyrealname.cachix.org-1:livOzeSQwWDD2XUFIspxkMCcu7Pi+angYDoLajI6T/k="
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
    ];
  };
}