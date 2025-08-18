{
  imports = [
    ./hellwal
    ./matugen
    ./general.nix
    ./fonts.nix
  ];

  xdg.configFile."gtk-3.0/gtk.css".source = ./gtk3.css;
}
