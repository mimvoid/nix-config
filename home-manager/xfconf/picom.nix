{ pkgs, lib, ... }:

{
  xfconf.settings.xfwm4."general/use_compositing" = false;

  services.picom = {
    enable = true;
    package = pkgs.unstable.picom;
    backend = "glx";

    fade = true;
    fadeDelta = 2;

    activeOpacity = 0.85;
    inactiveOpacity = 0.7;
    menuOpacity = 0.85;
    opacityRules = [
      "100:fullscreen"
      "100:class_g = 'firefox' && focused"
      "100:class_g = 'Vivaldi-stable' && focused"
      "100:class_g = 'krita'"
      "100:class_g *?= 'ristretto'"
      "100:class_g = 'zoom'"
      "100:class_g *?= 'virt-manager'"
      "98:class_g *?= 'obsidian' && focused"
      "98:class_g *?= 'zotero' && focused"
      "80:class_g = 'kitty' && focused"
    ];

    shadow = true;
    shadowOpacity = 0.5;
    shadowOffsets = [ (-20) (-20) ];
    shadowExclude =
      lib.lists.map (i: "window_type *= '${i}'") [
        "menu"
        "dropdown_menu"
        "popup_menu"
        "utility"
        "notification"
        "dock"
        "toolbar"
        "tooltip"
      ]
      ++ [ "class_g = 'firefox' && argb" ];

    vSync = true;

    settings = {
      corner-radius = 10;
      rounded-corners-exclude = [ "window_type = 'desktop'" ];

      blur = {
        method = "dual_kawase";
        strength = 1;
      };
      blur-exclude = [ "class_g = 'firefox'" ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      unredir-if-possible = false;
      detect-transient = true;
      detect-client-leader = false;
    };
  };

  xdg.configFile."picom/picom.conf".text =
    let
      curve = "cubic-bezier(0.05, 0.9, 0.1, 1.05)";
      duration = "0.2";
    in
    lib.mkAfter ''
      animations = ({
        triggers = [ "close", "hide", "open", "show", "geometry" ];
        scale-x = {
          curve = "${curve}";
          duration = ${duration};
          start = "window-width-before / window-width";
          end = 1;
        };
        scale-y = {
          curve = "${curve}";
          duration = ${duration};
          start = "window-height-before / window-height";
          end = 1;
        };
        offset-x = {
          curve = "${curve}";
          duration = ${duration};
          start = "window-x-before - window-x";
          end = 0;
        };
        offset-y = {
          curve = "${curve}";
          duration = ${duration};
          start = "window-y-before - window-y";
          end = 0;
        };

        shadow-scale-x = "scale-x";
        shadow-scale-y = "scale-y";
        shadow-offset-x = "offset-x";
        shadow-offset-y = "offset-y";
      })
    '';
}
