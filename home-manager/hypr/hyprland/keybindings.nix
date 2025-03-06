{ pkgs, terminal, ... }:
let
  # Default applications
  launcher = "fuzzel";
  browser = "firefox";
  file-manager = "thunar";
  todo = "kitty dooit";
  music-player = "tauon";

  # Commands
  screenshot =
    let
      hyprshot = "${pkgs.hyprshot}/bin/hyprshot";

      dir = "$(xdg-user-dir PICTURES)/Screenshots";
      filename = "$(date +%F_%H-%M-%S).png";
    in
    {
      screen = "${hyprshot} -m output -o ${dir} -f ${filename}";
      window = "${hyprshot} -m window -o ${dir} -f ${filename}";
      region = "${hyprshot} -m region -o ${dir} -f ${filename}";
    };
in
{
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

    "$mod, A, exec, krita"
    "$mod, O, exec, obsidian"
    "$mod, N, exec, networkmanager_dmenu"

    # Screenshot
    ", Print, exec, ${screenshot.screen}"
    "$mod, Print, exec, ${screenshot.window}"
    "$mod SHIFT, Print, exec, ${screenshot.region}"

    # Colorpicker
    "$mod, C, exec, hyprpicker --autocopy --format=hex"

    # Toggle session menu
    "$mod SHIFT, Q, exec, ags toggle \"session\""

    # Reload
    # I use this binding to manually reload config changes.
    # Having AGS reload also serves as a good visual indicator.
    # You can replace it with any bar (e.g. waybar) you like.
    "$mod, R, exec, hyprctl reload config-only"
    "$mod, R, exec, pkill xfce4-notifyd ; ags quit ; ags run --gtk4 &"

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
}
