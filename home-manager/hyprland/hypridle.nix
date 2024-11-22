# I find sets within lists to be rather unreadable
# So I defined them here first

let
  idle-warning = {
    timeout = 540;
    on-timeout = "notify-send 'Hypridle' 'Are you there...?'";
    on-resume = "notify-send 'Hypridle' 'Welcome back!'";
  };

  lock = {
    timeout = 600;
    on-timeout = "hyprlock";
  };

  screen-off = {
    timeout = 900;
    on-timeout = "hyprctl dispatch dpms off";
    on-resume = "hyprctl dispatch dpms on";
  };

  suspend = {
    timeout = 1200;
    on-timeout = "systemctl suspend";
  };
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        idle-warning
        lock
        screen-off
        suspend
      ];
    };
  };
}
