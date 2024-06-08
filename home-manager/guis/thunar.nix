{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.tumbler
    gvfs
  ];

  xfconf.settings = {
    thunar = {
      "last-view" = "ThunarIconView";
      "last-icon-view-zoom-level" = "THUNAR_ZOOM_LEVEL_100_PERCENT";
      "last-separator-position" = 170;
      "last-window-maximized" = true;
      "last-window-width" = 640;
      "last-window-height" = 480;
      "last-show-hidden" = true;
    };
  };
}
