{ ... }:

{
    services.hypridle = {
        enable = true;
        settings = {
            general = {
                lock_cmd = "pidof hyprlock || hyprlock";
                before_sleep_cmd = "loginctl lock-session";
                after_sleep_cmd = "hyprctl dispatch dpms on";
            };

            listener = [
                {
                    # Idle warning
                    timeout = 540;
                    on-timeout = "notify-send 'Hypridle' 'Are you there...?'";
                    on-resume = "notify-send 'Hypridle' 'Welcome back!'";
                }
                {
                    # Screen locking
                    timeout = 600;
                    on-timeout = "hyprlock";
                }
                {
                    # Screen off
                    timeout = 900;
                    on-timeout = "hyprctl dispatch dpms off";
                    on-resume = "hyprctl dispatch dpms on";
                }
                {
                    # Suspend
                    timeout = 1200;
                    on-timeout = "systemctl suspend";
                }
            ];
        };
    };
}
