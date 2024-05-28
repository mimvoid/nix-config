programs.hypridle = {
        enable = true;
        settings = {

        general = {
            lock_cmd = "hyprlock";
            after_sleep_cmd = "hyprctl dispatch dpms on";
            ignore_dbus_inhibit = false;
        };

        listener = [
            # Idle warning
            {
                timeout = 540;
                on-timeout = "notify-send 'Hypridle' 'Are you there...?'";
                on-resume = "notify-send 'Hypridle' 'Welcome back!'";
            }
        # Screen locking
        {
          timeout = 600;
          on-timeout = "hyprlock";
          on-resume = "notify-send 'Hyprland' 'Welcome back!'";
        }
        # Sleep
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl d
