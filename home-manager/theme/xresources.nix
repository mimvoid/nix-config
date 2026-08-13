{ pkgs, ... }:
let
  inherit (pkgs.theme) fonts;
  c = pkgs.palettes.moonfall-eve.hexNoHashtag.base16;
in
{
  xresources.properties = {
    "*.faceName" = fonts.monospace.name;
    "*.faceSize" = fonts.terminal-size;
    "*.renderFont" = true;

    "*foreground" = c.base05;
    "*background" = c.base00;
    "*cursorColor" = c.base05;
    "*color0" = c.base00;
    "*color1" = c.base08;
    "*color2" = c.base0B;
    "*color3" = c.base0A;
    "*color4" = c.base0D;
    "*color5" = c.base0E;
    "*color6" = c.base0C;
    "*color7" = c.base05;
    "*color8" = c.base02;
    "*color9" = c.base08;
    "*color10" = c.base0B;
    "*color11" = c.base0A;
    "*color12" = c.base0D;
    "*color13" = c.base0E;
    "*color14" = c.base0C;
    "*color15" = c.base07;
    "*color16" = c.base09;
    "*color17" = c.base0F;
    "*color18" = c.base01;
    "*color19" = c.base02;
    "*color20" = c.base04;
    "*color21" = c.base06;
  };
}
