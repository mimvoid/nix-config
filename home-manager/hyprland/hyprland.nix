{ pkgs, config, ... }:
let
  # Default applications
  terminal = "kitty";
  launcher = "fuzzel";
  browser = "firefox";
  file-manager = "thunar";
  todo = "kitty dooit";
  music-player = "tauon";
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

    windowrule = [ "pseudo, fcitx" ];
    windowrulev2 =
      let
        opacity = {
          more = { id ? "class" }: name: "opacity 0.9 override 0.75 override, ${id}:(${name})";
          high = name: "opacity 0.97 override 0.85 override, class:(${name})";
          active = name: "opacity 1.0 override 0.85 override, class:(${name})";
          full = name: "opaque, class:(${name})";
        };
      in
      with opacity;
        [
          (more { id = "title"; } "*Nextcloud")
          (more { } "Anki")
          (more { } "org.pwmt.zathura")
          (more { } "com.github.flxzt.rnote")

          (high "obsidian")
          (high "vesktop")

          (active "firefox")
          (active "FFPWA*")

          (full "krita")
          (full "org.inkscape.Inkscape")
          (full "virt-manager")
        ]
        ++ [
          "suppressevent maximize, class:.*"
          "opacity 0.8 override 0.7 override, class:(${terminal})"

          # Make Zotero plugin notifications less intrusive
          "float, class:^(Zotero)$, title:^(Progress)$"
          "noinitialfocus, class:^(Zotero)$, title:^(Progress)$"
          "move 100% 100%, class:^(Zotero)$, title:^(Progress)$"
          "maxsize 75 50, class:^(Zotero)$, title:^(Progress)$"
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
      "$mod ALT, H, resizeactive, -10 0"
      "$mod ALT, L, resizeactive, 10 0"
      "$mod ALT, K, resizeactive, 0 -10"
      "$mod ALT, J, resizeactive, 0 10"
    ];

    bind = [
      # Launch
      "$mod, Return, exec, ${terminal}"
      "$mod, E, exec, ${file-manager}"
      "$mod, SPACE, exec, ${launcher}"
      "$mod, W, exec, ${browser}"
      "$mod, D, exec, ${todo}"
      "$mod, M, exec, ${music-player}"

      "$mod, O, exec, obsidian"
      "$mod, N, exec, networkmanager_dmenu"

      # Screenshot
      ", Print, exec, hyprshot -m output" # whole screen
      "$mod, Print, exec, hyprshot -m window" # one window
      "$mod SHIFT, Print, exec, hyprshot -m region" # selection

      # Colorpicker
      "$mod, C, exec, hyprpicker --autocopy --format=hex"

      # Toggle session menu
      "$mod SHIFT, Q, exec, ags toggle \"session\""

      # Reload
      # I use this binding to manually reload config changes.
      # Having AGS reload also serves as a good visual indicator.
      # You can replace it with any bar (e.g. waybar) you like.
      "$mod, R, exec, hyprctl reload config-only"
      "$mod, R, exec, ags quit && ags run &"

      # Toggle fullscreen
      "$mod, F, fullscreen"

      # Exit
      "$mod, Q, killactive"

      # Switch focus
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"

      # Move windows
      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, L, movewindow, r"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, J, movewindow, d"
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
