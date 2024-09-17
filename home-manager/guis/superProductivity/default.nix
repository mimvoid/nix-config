{ pkgs, ... }:
let
  # Override the desktop entry's name
  sp = pkgs.unstable.super-productivity.overrideAttrs (prev: {
    postInstall = (prev.postInstall or "") + ''
      substituteInPlace $out/share/applications/${prev.pname}.desktop \
      --replace "superProductivity" "Super Productivity"
    '';
  });
in
{
  home.packages = [ sp ];

  xdg.configFile = {
    "superProductivity/styles.css".source = ./styles.css;
  };
}
