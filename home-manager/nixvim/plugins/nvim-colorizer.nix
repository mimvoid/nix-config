{
  programs.nixvim.plugins.nvim-colorizer = {
    enable = true;
    userDefaultOptions = {
      mode = "background"; # "foreground", "background", "virtualtext"
      RGB = true; # like #ccc
      RRGGBB = true; # like #ee99b0
      RRGGBBAA = true; # like #ee99b0bb
      css = true; # css features
      css_fn = true; # css functions rgb_fn and hsl_fn
      names = false; # like blue or maroon
    };
  };
}
