{ pkgs, lib, ... }:
let
  leggie = pkgs.callPackage ../pkgs/fonts/leggie {};
in
{
  console = {
    font = "leggie-24";
    packages = [ leggie ];
    useXkbConfig = true;

    colors = lib.lists.map (i: lib.strings.removePrefix "#" i)
    [
      # catppuccin mocha
      "#11111b" # crust      black
      "#f38ba8" # red        red
      "#a6e3a1" # green      green
      "#f9e2af" # yellow     yellow
      "#89b4fa" # blue       blue
      "#f5c2e7" # pink       magenta
      "#94e2d5" # teal       cyan
      "#a6adc8" # subtext 0  gray
      "#45475a" # surface 1  dark gray
      "#f38ba8" # red        light red
      "#a6e3a1" # green      light green
      "#f9e2af" # yellow     light yellow
      "#89b4fa" # blue       light blue
      "#f5c2e7" # pink       light magenta
      "#94e2d5" # teal       light cyan
      "#cdd6f4" # text       white
    ];
  };
}
