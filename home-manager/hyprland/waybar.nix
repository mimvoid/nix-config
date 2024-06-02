{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    
   style = ./waybar-style.css;
   settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        passthrough = false;

        height = 28;
        spacing = 4;
        fixed-center = true;
        margin-left = 8;
        margin-right = 8;
        margin-top = 2;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "pulseaudio"
          "battery"
          "custom/power"
        ];

        # Module settings
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          format = "{icon}";
          show-special = false;
          on-click = "activate";

          format-icons = {
            active = "";
            default = "";
          };
        };

        clock = {
          format = "{:%A %b %d / %H:%M}";
        };

        network = {
          format = "{ifname}";
          format-wifi = "{icon}  {signalStrength}%";
          format-ethernet = "󰌘";
          format-disconnected = "󰌙";
          tooltip-format = "{ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-linked = "󰈁 {ifname} (No IP)";
          tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
          tooltip-format-ethernet = "{ifname} 󰌘";
          tooltip-format-disconnected = "󰌙 Disconnected";
          #on-click = "nm-applet --indicator";
          max-length = 50;
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} 󰂰 {volume}%";
          format-muted = "󰖁";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "󰕾" ""];
          };
        };

        battery = {
          bat = "BAT0";
          adapter = "ADP0";
          full-at = 97;
          design-capacity = false;
          states = {
            good = 95;
            warning = 40;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-alt-click = "click";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-time = "{H}h {M}min";
          tooltip = true;
          tooltip-format = "{timeTo} {power}w";
        };

        "custom/power" = {
          format = "⏻ ";
          exec = "echo ; echo 󰟡 power // blur";
          on-click = "wlogout -b 2";
          tooltip = false;
        };
      };
    };
  };
}
