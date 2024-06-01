{ config, inputs, pkgs, ... }:
let
    # Default applications
    terminal = "foot";
    launcher = "fuzzel";
    bar = "waybar";
    browser = "firefox";
    fileManager = "thunar";

    # Used in keymaps
    left = "H";
    down = "J";
    up = "K";
    right = "L";

    inherit (pkgs) polkit_gnome callPackage;
in
{
    wayland.windowManager.hyprland = {
        enable = true;
        systemd = {
            enable = true;
            variables = ["--all"];
        };
        xwayland.enable = true;
        
        extraConfig = "
            monitor = ,preferred,auto,auto
            xwayland {
                force_zero_scaling = true
            }
        ";

        settings = {
            # Startup & daemons
            exec-once = [
                "systemctl --user import-environment &"
                # "dbus-update-activation-environment --systemd --all &" # Redundant
                "dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus &"
                "${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
                "hypridle &"
                "mako &"
            ];

            exec = [
                # Includes swaybg, specified in hypr-theme.nix
                "wlsunset &"
                "nm-applet --indicator &"
                "waybar"
            ];

            env = [
                "XDK_CURRENT_DESKTOP, Hyprland"
                "XDK_SESSION_TYPE, wayland"
                "XDK_SESSION_DESKTOP, Hyprland"

                "GDK_scale, 1"
                "GDK_BACKEND, wayland, x11, *"

                "QT_AUTO_SCREEN_SCALE_FACTOR, 1_SCALE_FACTOR, 1"
                "QT_QPA_PLATFORM, wayland; xcb"
                "QT_QPA_PLATFORMTHEME,qt6ct"
                "QT_QPA_scale, 2"
                "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

                #"XCURSOR_THEME,"
                "XCURSOR_SIZE, 24"
                "HYPRCURSOR_SIZE, 24"
            ];

            #---------#
            # Layouts #
            #---------#

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            #-----------------#
            # Window settings #
            #-----------------#

            general = {
                gaps_in = 4;
                gaps_out = 8;

                border_size = 1;

                resize_on_border = true;
                allow_tearing = false;
                layout = "dwindle";
            };

            decoration = {
                rounding = 6;

                active_opacity = 0.80;
                inactive_opacity = 0.70;

                drop_shadow = true;
                shadow_range = 2;
                shadow_render_power = 2;

                blur = {
                    enabled = true;
                    size = 1;
                    passes = 1;
                    contrast = 1.40;
                };
            };

            windowrulev2 = [
                "suppressevent maximize, class:.*"
                "opacity 1.0 override 0.90 override, class:(firefox)"
                "opacity 1.0 override 0.90 override, class:(elisa)"
                "opacity 1.0 override 0.90 override, class:(FreeTube)"
                "opacity 0.90 override 0.85 override, title:(YaST2*)"
                "opacity 0.98 override 0.85 override, class:(Zotero)"
                "opacity 0.98 override 0.85 override class:(obsidian)"
                "opaque, class:(krita)"
            ];

            animations = {
                enabled = true;
                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
                animation = [
                    "windows, 1, 2, myBezier"
                    "windowsOut, 1, 2, default, popin 80%"
                    "border, 1, 3, default"
                    "borderangle, 1, 2, default"
                    "fade, 1, 2, default"
                    "workspaces, 1, 2, default"
                ];
            };

            #---------------#
            # Miscellaneous #
            #---------------#

            input = {
                kb_layout = "us";
                #kb_variant = 
                #kb_model = 
                #kb_options =
                #kb_rules = 

                follow_mouse = "1";

                sensitivity = "0";

                touchpad.natural_scroll = false;
            };

            gestures.workspace_swipe = false;

            misc = {
                force_default_wallpaper = 0;
                disable_hyprland_logo = true;
            };

            #-------------#
            # Keybindings #
            #-------------#

            "$mod" = "SUPER";
            bindm = [
                "$mod, mouse:272, movewindow"
                "$mod, mouse:272, resizewindow"
            ];
            bind = [
                # Launch
                "$mod, Return, exec, ${terminal}"
                "$mod, E, exec, ${fileManager}"
                "$mod, SPACE, exec, ${launcher}"
                "$mod, W, exec, ${browser}"

                # Exit
                "$mod, Q, killactive"

                # Reload
                "$mod, R, exec, pkill waybar ; hyprctl reload config-only"

                # Trigger wlogout
                "$mod SHIFT, Q, exec, wlogout -b 2"

                # Switch focus
                "$mod, ${left}, movefocus, l"
                "$mod, ${right}, movefocus, r"
                "$mod, ${up}, movefocus, u"
                "$mod, ${down}, movefocus, d"

                # Screenshot
                "$mod, Print, exec, hyprshot -m window"
                ", Print, exec, hyprshot -m output"
                "$mod SHIFT, Print, exec, hyprshot -m region"
            ]
            ++ (
                # Workspaces
                # $mod + {1..10} to workspace {1..10}
                # $mod + shift + {1..10} to move to workspace {1..10}
                builtins.concatLists (builtins.genList (
                    x: let
                        ws = let
                        c = (x + 1) / 10;
                    in
                        builtins.toString (x + 1 - (c * 10));
                    in [
                        "$mod, ${ws}, workspace, ${toString (x + 1)}"
                        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                    ]
                )
                10)
            );
        };
            
    };
}
