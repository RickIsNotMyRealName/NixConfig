{ config, ... }:
{
  mainBar = {
    "layer" = "top";
    "position" = "top";
    # "height" = 35;
    "spacing" = 4;
    "margin-top" = 5;
    "margin-bottom" = 0;



    "modules-left" = [
      "group/power-group"
      "keyboard-state"
      "battery"
      "custom/chatgpt"
      "custom/exalidraw"
      "custom/messages"
      "custom/calendar"
    ];

    # Choose the order of the modules
    "modules-center" = [
      "clock"
      "hyprland/workspaces"
      "tray"
    ];

    "modules-right" = [
      "cpu"
      "memory"
      "disk"
      "backlight"
      "pulseaudio"
      "network"
      "bluetooth"
    ];

    # Modules configuration

    "group/power-group" = {
      "orientation" = "inherit";
      "drawer" = {
        "transition-duration" = 500;
        "children-class" = "not-power";
        "transition-left-to-right" = true;
      };
      "modules" = [
        "custom/power"
        "custom/quit"
        "custom/lock"
        "custom/reboot"
      ];
    };

    "hyprland/workspaces" = {
      "disable-scroll" = true;
      "all-outputs" = false;
      "format" = "{icon}";
      "format-icons" = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8 - ";
        "9" = "9 - ";
        "10" = "0 - ";
        "urgent" = "";
        # "active" = "";
        "default" = "";
      };

    };
    "keyboard-state" = {
      "numlock" = true;
      "capslock" = true;
      "format" = "{name} {icon}";
      "format-icons" = {
        "locked" = "";
        "unlocked" = "";
      };
    };
    "hyprland/mode" = {
      "format" = "<span style=\"italic\">{}</span>";
    };
    "idle_inhibitor" = {
      "format" = "{icon}";
      "format-icons" = {
        "activated" = "";
        "deactivated" = "";
      };
    };
    "tray" = {
      "icon-size" = 16;
      "spacing" = 10;
      "show-passive-items" = true;
    };
    "clock" = {
      "timezone" = "America/Edmonton";
      "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      "format-alt" = "{:%b %d, %G}";
      "format" = "{:%I:%M %p}";

    };
    "cpu" = {
      "format" = "{usage}% ";
      "tooltip" = true;
      "tooltip-format" = "{usage}% ";

    };
    "memory" = {
      "format" = "{}% ";
    };
    "disk" = {
      "path" = "/";
      "format" = "{percentage_used}% ";
      "tooltip" = true;
      "tooltip-format" = "{used} used out of {total} on {path} ({percentage_used}%)";
    };
    "backlight" = {
      # "device" = "acpi_video1";
      "format" = "{percent}% {icon}";
      "format-icons" = [ "" "" ];
    };
    "battery" = {
      "states" = {
        # "good" = 95;
        "warning" = 30;
        "critical" = 15;
      };
      "format" = "{capacity}% {icon}";
      "format-charging" = "{capacity}% ";
      "format-plugged" = "{capacity}% ";
      "format-alt" = "{time} {icon}";
      # "format-good" = ""; # An empty format will hide the module
      # "format-full" = "";
      "format-icons" = [ "" "" "" "" "" ];
    };
    "network" = {
      # "interface" = "wlp2*"; # (Optional) To force the use of this interface
      "format-wifi" = " {signalStrength}%";
      "tooltip-format-wifi" = "{essid}\nInterface: {ifname}\nGateway: {gwaddr}\nIP: {ipaddr}/{cidr}";

      "format-ethernet" = "Connected  ";
      "tooltip-format-ethernet" = "Interface: {ifname}\nGateway: {gwaddr}\nIP: {ipaddr}/{cidr}";


      "format-linked" = "{ifname} (No IP) ";
      "format-disconnected" = "Disconnected ⚠";
      "on-click-right" = "bash ~/.config/wofi/wifi_menu/wofi_wifi_menu";
    };
    "pulseaudio" = {
      # "scroll-step" = 1; # %; can be a float
      "format" = "{volume}% {icon}";
      "format-bluetooth" = "{volume}% {icon}";
      "format-bluetooth-muted" = "{icon} {format_source}";
      "format-muted" = "{format_source}";
      "format-source" = "";
      "format-source-muted" = "";
      "format-icons" = {
        "headphone" = "";
        "hands-free" = "";
        "headset" = "";
        "phone" = "";
        "portable" = "";
        "car" = "";
        "default" = [ "" "" "" ];
      };
      "on-click" = "pavucontrol";
    };
    # "custom/chatgpt" = {
    #   "format" = "";
    #   "tooltip" = true;
    #   "tooltip-format" = "Open ChatGPT";
    #   "on-click" = "firefox --app=https://chat.openai.com";
    # };
    # "custom/exalidraw" = {
    #   "format" = "";
    #   "tooltip" = true;
    #   "tooltip-format" = "Open Excalidraw";
    #   "on-click" = "firefox --app=https://excalidraw.com/";
    # };
    # "custom/messages" = {
    #   "format" = "";
    #   "tooltip" = true;
    #   "tooltip-format" = "Open Google Messages";
    #   "on-click" = "firefox --app=https://messages.google.com/web";
    # };
    # "custom/calendar" = {
    #   "format" = "";
    #   "tooltip" = true;
    #   "tooltip-format" = "Open Google Calendar";
    #   "on-click" = "firefox --app=https://calendar.google.com";
    # };

    "custom/quit" = {
      "format" = "󰗼";
      "tooltip" = true;
      "on-click" = "hyprctl dispatch exit";
      "tooltip-format" = "{icon} Quit Application";
    };
    "custom/lock" = {
      "format" = "󰍁";
      "tooltip" = true;
      "on-click" = "hyprlock";
      "tooltip-format" = "Lock Screen";
    };

    "custom/reboot" = {
      "format" = "󰜉";
      "tooltip" = true;
      "on-click" = "systemctl reboot";
      "tooltip-format" = "Reboot";
    };
    "custom/power" = {
      "format" = "";
      "tooltip" = true;
      "on-click" = "systemctl poweroff";
      "tooltip-format" = "Shutdown";
    };

    "bluetooth" = {
      "format" = " {status}";
      "format-disabled" = "";
      # // an empty format will hide the module
      "format-connected" = " {device_alias}";
      "tooltip-format" = "{device_alias}";
      "tooltip-format-connected" = " {device_enumerate}";
      "tooltip-format-enumerate-connected" = "{device_alias}";
      "on-click" = "blueman-manager";
    };
  };
}
