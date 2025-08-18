{ config, pkgs, ... }:

{
  # View .webp thumbnails
  home.packages = [ pkgs.webp-pixbuf-loader ];

  xfconf.settings.thunar = {
    "last-view" = "ThunarIconView";
    "last-icon-view-zoom-level" = "THUNAR_ZOOM_LEVEL_100_PERCENT";
    "last-show-hidden" = true;

    "last-location-bar" = "ThunarLocationButtons";
    "misc-image-preview-mode" = "THUNAR_IMAGE_PREVIEW_MODE_EMBEDDED";

    "last-restore-tabs" = true;
    "misc-confirm-close-multiple-tabs" = false;

    "misc-single-click" = false;
    "misc-case-sensitive" = false;
    "misc-show-delete-action" = true;
    "hidden-bookmarks" = [
      "file://${config.home.homeDirectory}/Desktop"
      "computer:///"
    ];
  };
}
