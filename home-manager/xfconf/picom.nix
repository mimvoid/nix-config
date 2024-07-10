{
  xfconf.settings.xfwm4."general/use_compositing" = false;

  services.picom = {
    enable = true;
    backend = "glx";

    fade = true;
    fadeDelta = 2;

    activeOpacity = 0.85;
    inactiveOpacity = 0.7;
    menuOpacity = 0.85;
    opacityRules = [
      "100:class_g = 'firefox' && focused"
      "100:class_g = 'krita'"
      "100:class_g *?= 'ristretto'"
      "100:class_g = 'zoom'"
      "98:class_g *?= 'obsidian' && focused"
      "98:class_g *?= 'zotero' && focused"
      "80:class_g = 'xterm' && focused"
    ];

    shadow = true;
    shadowOpacity = 0.5;
    shadowOffsets = [ (-20) (-20) ];
    shadowExclude = let
      win = type: "window_type *= '${type}'";
    in [
      (win "menu")
      (win "dropdown_menu")
      (win "popup_menu")
      (win "utility")
      (win "notification")
      (win "dock")
      (win "toolbar")
      (win "tooltip")
      "class_g = 'firefox' && argb"
    ];

    settings = {
      corner-radius = 10;
      rounded-corners-exclude = [ "window_type = 'desktop'" ];

      blur = {
        method = "dual_kawase";
        strength = 1;
      };
      blur-exclude  = [
        "class_g = 'firefox'"
      ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      vsync = true;
      unredir-if-possible = false;
      detect-transient = true;
      detect-client-leader = false;
    };
  };
}
