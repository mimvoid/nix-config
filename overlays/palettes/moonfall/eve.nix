# Moonfall Eve color palette

let
  names = {
    nadir = "#25223a";
    surface = "#302c47";
    zenith = "#37324f";
    cloudline = "#5c5478";
    skyline = "#9c92aa";
    horizon = "#e8dfdd";

    cardinal = "#f280aa";
    glow = "#eda2b5";
    sprout = "#7098de";
    wisp = "#b1b5e4";
    ripple = "#a675eb";
    petal = "#d87dd6";

    mirage = "#44415b";
    halo = "#52486d";
  };

  generic = with names; {
    black = nadir;
    white = horizon;
    red = cardinal;
    yellow = glow;
    green = sprout;
    cyan = wisp;
    blue = ripple;
    magenta = petal;
  };

  base16 = with names; {
    base00 = nadir;
    base01 = surface;
    base02 = zenith;
    base03 = cloudline;
    base04 = skyline;
    base05 = horizon;
    base06 = horizon;
    base07 = mirage;
    base08 = cardinal;
    base09 = petal;
    base0A = glow;
    base0B = sprout;
    base0C = wisp;
    base0D = ripple;
    base0E = petal;
    base0F = halo;
  };
in
names // generic // base16 // { inherit base16; }
