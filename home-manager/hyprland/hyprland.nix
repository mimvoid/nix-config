{ pkgs, ... }:
let
  # Default applications
  terminal = "foot";
  launcher = "fuzzel";
  browser = "firefox-beta";
  fileManager = "thunar";

  # Used in keymaps
  left = "H";
  down = "J";
  up = "K";
  right = "L";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = { enable = true; variables = ["--all"]; };
    xwayland.enable = true;
        
    extraConfig = ''
      monitor = ,preferred,auto,auto
      xwayland {
        force_zero_scaling = true
      }
    '';
  };

  wayland.windowManager.hyprland.settings = {
    # Startup & daemons
    exec-once = [
      "systemctl --user import-environment &" 
      "dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus &"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
      "${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon &"
      "hypridle &"
      "mako &"
      # Includes swww daemon, see ./hypr-theme.nix
    ];

    exec = [
      "nm-applet --indicator &"
      # Don't have programs with systemd targets here (unless you want two of them)
      # If their systemd.target = "hyprland-session.target";
      # At least I think that's how it works
    ];

    env = [
      "XDK_CURRENT_DESKTOP, Hyprland"
      "XDK_SESSION_TYPE, wayland"
      "XDK_SESSION_DESKTOP, Hyprland"

      "GDK_scale, 1"
      "GDK_BACKEND, wayland, x11, *"

      "QT_AUTO_SCREEN_SCALE_FACTOR, 1_SCALE_FACTOR, 1"
      "QT_QPA_PLATFORM, wayland; x11"
      "QT_QPA_PLATFORMTHEME, gtk3"
      "QT_QPA_scale, 2"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

      #"XCURSOR_THEME,"
      "XCURSOR_SIZE, 24"
      "HYPRCURSOR_SIZE, 24"
    ];

    windowrulev2 =
    let
      opaque-ish = val: "opacity 0.98 override 0.85 override, class:(${val})";
      active-opaque = val: "opacity 1.0 override 0.85 override, class:(${val})";
      opaque = val: "opaque, class:(${val})";
    in
    [
      "suppressevent maximize, class:.*"
      (opaque-ish "Freetube")
      (opaque-ish "Zotero")
      (opaque-ish "obsidian")
      (opaque-ish "vesktop")
      (active-opaque "firefox")
      (opaque "ristretto")
      (opaque "krita")
    ];

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    general = {
      layout = "dwindle";
      
      gaps_in = 4;
      gaps_out = 8;
      border_size = 1;

      resize_on_border = true;
      allow_tearing = false;
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
        contrast = 1.25;
      };
    };

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
      follow_mouse = "1";
      sensitivity = "0";
      touchpad.natural_scroll = false;

      kb_layout = "us";
      #kb_variant = 
      #kb_model = 
      #kb_options =
      #kb_rules = 
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
      "$mod, mouse:272, resizewindow"
      "$mod, mouse:273, movewindow"
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
      "$mod, R, exec, pkill waybar && waybar ; hyprctl reload config-only"

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
    ] ++ (
      # Workspaces
      # $mod + {1..10} for workspace {1..10}
      # $mod + shift + {1..10} for move to workspace {1..10}
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
}
