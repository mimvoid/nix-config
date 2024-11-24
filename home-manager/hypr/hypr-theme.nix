{ config, ... }:
let
  pal = config.palette;
  type = config.stylix.fonts;
in
{
  wayland.windowManager.hyprland.settings = {
    general = with pal; {
      "col.active_border" = "rgb(${primary})";
      "col.inactive_border" = "rgba(${primary-dim}40)"; # 25% opacity
    };

    decoration."col.shadow" = "rgba(${pal.shadow}33)"; # 20% opacity
  };

  programs.fuzzel.settings = {
    main.font = "${type.monospace.name}:size=9";

    colors = with pal;
      {
        background = base + "ee";
        text = string + "ff";
        match = secondary + "ff";
        selection = box-bright + "dd";
        selection-match = primary + "ff";
        selection-text = secondary-bright + "ff";
        border = error + "ff";
      };
  };
}
