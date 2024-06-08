{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    gvfs
  ];
}
