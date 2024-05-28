{ ... }:

{
  wlogout = {
    enable = true;
    style = ./wlogout-style.css
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "",
        keybind = "o";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "",
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "";
        keybind = "s";
      }
    ];
  }
}
