{ pkgs, config, ... }:
let
  # Default applications
  terminal = "kitty";

  keybindings = import ./keybindings.nix {
    inherit (pkgs) lib;
    inherit terminal;
  };

  windowrules = import ./windowrules.nix { inherit terminal; };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;

    extraConfig = # hyprlang
      ''
        general {
          gaps_out = 4,12,12,12 # for top bar
        }
        decoration {
          shadow_offset = 2 2
        }
      '';
  };

  wayland.windowManager.hyprland.settings = keybindings // windowrules // {
    # Startup & daemons
    # Includes swww daemon, see ./hypr-theme.nix
    exec-once = [
      "systemctl --user import-environment &"
      "dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus &"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
      "${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start &"
      "mega-cmd-server &"
      "fcitx5 -d &"
      "ags run &"
    ];

    # Don't have things with a systemd target for Hyprland here
    # (unless you want two of them)
    exec = [
      "nm-applet --indicator &"
    ];

    env = [
      "XDK_CURRENT_DESKTOP, Hyprland"
      "XDK_SESSION_TYPE, wayland"
      "XDK_SESSION_DESKTOP, Hyprland"

      "GDK_scale, 1"
      "GDK_BACKEND, wayland, x11, *"

      "QT_AUTO_SCREEN_SCALE_FACTOR, 1_SCALE_FACTOR, 1"
      "QT_QPA_PLATFORM, wayland; xcb"
      "QT_QPA_PLATFORMTHEME, gtk3"
      "QT_QPA_scale, 2"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

      "MOZ_ENABLE_WAYLAND, 1"

      # Enable Ozone Wayland for electron apps
      "NIXOS_OZONE_WL, 1"
      "ELECTRON_OZONE_PLATFORM_HINT, auto"
      # Anki
      "ANKI_WAYLAND, 1"
      # Fcitx adjustments
      "QT_IM_MODULES, wayland;fcitx"
      "GTK_IM_MODULE, "

      "XCURSOR_SIZE, 24"
      "XCURSOR_THEME, ${config.gtk.cursorTheme.name}"
      "HYPRCURSOR_SIZE, 24"
      "HYPRCURSOR_THEME, ${config.gtk.cursorTheme.name}"
    ];

    monitor = ",preferred,auto,auto";
    xwayland.force_zero_scaling = true;

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    general = {
      layout = "dwindle";

      gaps_in = 4;
      gaps_out = 12;
      border_size = 1;

      resize_on_border = true;
      allow_tearing = false;
    };

    decoration = {
      rounding = 5;

      active_opacity = 0.85;
      inactive_opacity = 0.7;
      fullscreen_opacity = 1.0;

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_range = 6;
      shadow_render_power = 1;

      blur = {
        enabled = true;
        new_optimizations = true;
        xray = true;
        size = 1;
        passes = 2;
        contrast = 1.2;
        noise = 0.02;
      };
    };

    animations = {
      enabled = true;
      first_launch_animation = true;
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
    };

    gestures.workspace_swipe = false;

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
    };
  };
}
