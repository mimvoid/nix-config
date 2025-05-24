{ pkgs, ... }:

{
  home.packages = with pkgs; [ unstable.picom ];

  xfconf.settings.xfwm4."general/use_compositing" = false;

  xdg.configFile."picom/picom.conf".text = ''
    backend = "glx";
    vsync = true;

    fading = true;
    fade-delta = 2;
    fade-in-step = 0.028;
    fade-out-step = 0.03;

    blur: {
      method = "dual_kawase";
      strength = 1;
    }

    shadow = false;
    shadow-offset-x = -20;
    shadow-offset-y = -20;
    shadow-opacity = 0.5;

    detect-client-leader = false;
    detect-client-opacity = true;
    detect-rounded-corners = true;
    detect-transient = true;
    mark-wmmin-focused = true;
    unredir-if-possible = true;

    rules = (
      { opacity = 0.85; corner-radius = 10; },
      {
        match = "window_type = 'normal' && !focused";
        opacity = 0.7;
      },
      {
        # Opaque windows
        match = "fullscreen || "
                "class_g = 'firefox' || "
                "class_g = 'krita' || "
                "class_g *?= 'ristretto' || "
                "class_g = 'zoom' || "
                "class_g *?= 'virt-manager' || "
                "class_g *?= 'org.kde.digikam'";
        opacity = 1.0;
        full-shadow = false;
        blur-background = false;
      },
      {
        # Almost opaque windows
        match = "(class_g *?= 'obsidian' || class_g *?= 'zotero') && focused";
        opacity = 0.95;
      },
      {
        # Terminal
        match = "class_g = 'kitty' && focused";
        opacity = 0.8;
      },
      {
        match = "class_g = 'firefox'";
        blur-background = false;
      },
      {
        match = "class_g = 'firefox' && argb";
        shadow = false;
      },

      # Window types
      {
        match = "window_type = 'desktop'";
        corner-radius = 0;
      },
      {
        match = "window_type = 'dropdown_menu' || "
                "window_type = 'popup_menu'";
        opacity = 0.85;
      },
      {
        match = "window_type = 'notification'";
        animations = (
          {
            triggers = [ "open", "show" ];
            preset = "fly-in";
            direction = "left";
          },
          {
            triggers = [ "close", "hide" ];
            preset = "fly-out";
            direction = "right";
          }
        )
      },
      {
        match = "window_type = 'normal'";
        shadow = true;
        animations = ({
          triggers = [ "close", "hide", "open", "show", "geometry" ];

          dur = 0.2;

          scale-x = {
            curve = "cubic-bezier(0.05, 0.9, 0.1, 1.05)";
            duration = "dur";
            start = "window-width-before / window-width";
            end = 1;
          };
          scale-y = {
            curve = "cubic-bezier(0.05, 0.9, 0.1, 1.05)";
            duration = "dur";
            start = "window-height-before / window-height";
            end = 1;
          };
          offset-x = {
            curve = "cubic-bezier(0.05, 0.9, 0.1, 1.05)";
            duration = "dur";
            start = "window-x-before - window-x";
            end = 0;
          };
          offset-y = {
            curve = "cubic-bezier(0.05, 0.9, 0.1, 1.05)";
            duration = "dur";
            start = "window-y-before - window-y";
            end = 0;
          };

          shadow-scale-x = "scale-x";
          shadow-scale-y = "scale-y";
          shadow-offset-x = "offset-x";
          shadow-offset-y = "offset-y";
        })
      }
    )
  '';
}
