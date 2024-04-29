{ pkgs, inputs, ... }:
{

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
  ];

  hardware = {
    opengl.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-wlr
      # pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
