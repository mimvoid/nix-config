{ pkgs, config, ... }:
let
  # Default applications
  terminal = "kitty";
  launcher = "fuzzel";
  browser = "firefox";
  fileManager = "thunar";
  obsidian = "obsidian";
  todo = "super-productivity";

  # Used in keymaps
  left = "H";
  down = "J";
  up = "K";
  right = "L";
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

  wayland.windowManager.hyprland.settings = {

    # Startup & daemons
    exec-once = [
      "systemctl --user import-environment &" 
      "dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus &"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
      "${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon &"
      "mega-cmd-server &"
      "fcitx5 -d &"
      "hypridle &"
      "ags &"
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
      "GTK_CSD, 0" # disable window decorations

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

      "XCURSOR_SIZE, 24"
      "XCURSOR_THEME, ${config.gtk.cursorTheme.name}"
      "HYPRCURSOR_SIZE, 24"
      "HYPRCURSOR_THEME, ${config.gtk.cursorTheme.name}"
    ];

    monitor = ",preferred,auto,auto";
    xwayland.force_zero_scaling = true;

    windowrule = [ "pseudo, fcitx" ];
    windowrulev2 =
    # TODO: think of better names for these
    let
      opaquer-title = val: "opacity 0.9 override 0.75 override, title:(${val})";
      opaquer-class = val: "opacity 0.9 override 0.75 override, class:(${val})";
      opaque-ish = val: "opacity 0.97 override 0.85 override, class:(${val})";
      active-opaque = val: "opacity 1.0 override 0.85 override, class:(${val})";
      opaque = val: "opaque, class:(${val})";
    in
    [
      "suppressevent maximize, class:.*"
      "opacity 0.8 override 0.7 override, class:(${terminal})"

      # Make Zotero plugin notifications less intrusive
      "float, class:^(Zotero)$, title:^(Progress)$"
      "noinitialfocus, class:^(Zotero)$, title:^(Progress)$"
      "move 100% 100%, class:^(Zotero)$, title:^(Progress)$"
      "maxsize 75 50, class:^(Zotero)$, title:^(Progress)$"

      (opaquer-title "*Nextcloud")
      (opaquer-class "Anki")
      (opaquer-class "org.pwmt.zathura")
      (opaque-ish "FreeTube")
      (opaque-ish "Zotero")
      (opaque-ish "obsidian")
      (opaque-ish "vesktop")
      (active-opaque "firefox")
      (active-opaque "zen-alpha")
      (opaque "ristretto")
      (opaque "krita")
      (opaque "org.inkscape.Inkscape")
      (opaque "virt-manager")
    ];

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

    #-------------#
    # Keybindings #
    #-------------#

    "$mod" = "SUPER";

    bindm = [
      "$mod, mouse:272, resizewindow"
      "$mod, mouse:273, movewindow"
    ];

    binde = [
      # Resize windows
      "$mod ALT, ${left}, resizeactive, -10 0"
      "$mod ALT, ${right}, resizeactive, 10 0"
      "$mod ALT, ${up}, resizeactive, 0 -10"
      "$mod ALT, ${down}, resizeactive, 0 10"
    ];

    bind = [
      # Launch
      "$mod, Return, exec, ${terminal}"
      "$mod, E, exec, ${fileManager}"
      "$mod, SPACE, exec, ${launcher}"
      "$mod, W, exec, ${browser}"
      "$mod, O, exec, ${obsidian}"
      "$mod, D, exec, ${todo}"

      "$mod, N, exec, networkmanager_dmenu"

      # Toggle fullscreen
      "$mod, F, fullscreen"

      # Exit
      "$mod, Q, killactive"

      # Reload
      # I use this binding to manually reload anything I'm interested in.
      # Having AGS reload also serves as a good visual indicator.
      # You can replace it with any bar (e.g. waybar) you like.
      "$mod, R, exec, hyprctl reload config-only"
      "$mod, R, exec, ags --quit && ags &"

      # Trigger wlogout
      "$mod SHIFT, Q, exec, wlogout -b 2"

      # Switch focus
      "$mod, ${left}, movefocus, l"
      "$mod, ${right}, movefocus, r"
      "$mod, ${up}, movefocus, u"
      "$mod, ${down}, movefocus, d"

      # Move windows
      "$mod SHIFT, ${left}, movewindow, l"
      "$mod SHIFT, ${right}, movewindow, r"
      "$mod SHIFT, ${up}, movewindow, u"
      "$mod SHIFT, ${down}, movewindow, d"

      # Screenshot
      "$mod, Print, exec, hyprshot -m window"
      ", Print, exec, hyprshot -m output"
      "$mod SHIFT, Print, exec, hyprshot -m region"

      # Colorpicker
      "$mod, C, exec, hyprpicker --autocopy --format=hex"
    ] ++ (
      # Workspaces
      # $mod + {1..10} for workspace {1..10}
      # $mod + shift + {1..10} for move to workspace {1..10}
      builtins.concatLists (
        builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
            builtins.toString (x + 1 - (c * 10));
          in
          [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        ) 10
      )
    );
  };
}
