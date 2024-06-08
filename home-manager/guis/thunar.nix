{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.tumbler
    gvfs
  ];

  # Unused for now
  xdg.configFile = {
    ".config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml" = {
      enable = false;
      text = # xml
      ''
        <channel name="thunar" version="1.0">
          <property name="last-view" type="string" value="ThunarIconView"/>
          <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_100_PERCENT"/>
          <property name="last-separator-position" type="int" value="170"/>
          <property name="last-window-maximized" type="bool" value="true"/>
          <property name="last-window-width" type="int" value="640"/>
          <property name="last-window-height" type="int" value="480"/>
          <property name="last-show-hidden" type="bool" value="true"/>
          <property name="misc-single-click" type="bool" value="false"/>
          <property name="misc-case-sensitive" type="bool" value="false"/>
        </channel>
      '';
    };
  };
}
