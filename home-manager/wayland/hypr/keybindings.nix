{ pkgs, terminal }:
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
      dir = "~/Pictures/Screenshots";
      file = "$(date +%F_%H-%M-%S).png";
      mkCommand = _: mode: "${pkgs.hyprshot}/bin/hyprshot -m ${mode} --freeze -o ${dir} -f ${file}";
    in
    builtins.mapAttrs mkCommand {
      screen = "output";
      window = "window";
      region = "region";
    };

  vim-motions = [
    { key = "H"; direction = "l"; resize = "-10 0"; }
    { key = "L"; direction = "r"; resize = "10 0"; }
    { key = "K"; direction = "u"; resize = "0 -10"; }
    { key = "J"; direction = "d"; resize = "0 10"; }
  ];
  mapVimMotions = f: builtins.map f vim-motions;
in
{
  "$mod" = "SUPER";

  bindm = [
    "$mod, mouse:272, resizewindow"
    "$mod, mouse:273, movewindow"
  ];

  # Resize windows
  binde = mapVimMotions (dir: "$mod ALT, ${dir.key}, resizeactive, ${dir.resize}");

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
    "$mod SHIFT, Q, exec, ags toggle 'session'"

    # Reload
    # I use this binding to manually reload config changes.
    # Having AGS reload also serves as a good visual indicator.
    # You can replace it with any bar (e.g. waybar) you like.
    "$mod, R, exec, hyprctl reload config-only"
    "$mod, R, exec, pkill xfce4-notifyd ; ags quit ; ags run"

    "$mod, F, fullscreen" # Toggle fullscreen
    "$mod, Q, killactive" # Exit
  ]
  ++ (
    # Switch focus
    mapVimMotions (dir: "$mod, ${dir.key}, movefocus, ${dir.direction}")
  )
  ++ (
    # Move windows
    mapVimMotions (dir: "$mod SHIFT, ${dir.key}, movewindow, ${dir.direction}")
  )
  ++ (
    # Workspaces
    # $mod + {1..10} for workspace {1..10}
    # $mod + shift + {1..10} for move to workspace {1..10}
    builtins.concatLists (
      builtins.genList (i: [
        "$mod, code:1${toString i}, workspace, ${toString (i + 1)}"
        "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString (i + 1)}"
      ]) 9
    )
  );
}
