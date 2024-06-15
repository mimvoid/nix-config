{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.tumbler
    gvfs
  ];

  xfconf.settings.thunar = {
    "last-view" = "ThunarIconView";
    "last-icon-view-zoom-level" = "THUNAR_ZOOM_LEVEL_150_PERCENT";
    "last-separator-position" = 170;
    "last-show-hidden" = true;
    "last-restore-tabs" = true;
    "misc-single-click" = false;
    "misc-case-sensitive" = false;
    "misc-show-delete-action" = true;
    "hidden-bookmarks" = [
      "file://${config.home.homeDirectory}/Desktop"
      "computer:///"
    ];
  };
}
