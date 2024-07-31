{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swaynotificationcenter
    # libnotify
  ];


  home.file = {
    #https://github.com/zDyanTB/HyprNova/blob/master/.config/swaync/

    ".config/swaync/config.json".source = ./config.json;
    ".config/swaync/style.css".source = ./style.css;
    ".config/swaync/theme/central_control.css".source = ./theme/central_control.css;
    ".config/swaync/theme/notifications.css".source = ./theme/notifications.css;
  };
}
