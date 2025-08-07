{
  imports = [
    ./hellwal
    ./matugen
    ./theming.nix
    ./fonts.nix
  ];

  xdg.configFile."gtk-3.0/gtk.css".source = ./gtk3.css;
}
