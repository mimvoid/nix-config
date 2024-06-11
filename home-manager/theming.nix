{ pkgs, ... }:
let
  # Wallpaper
  homescreen = ../wallpapers/bakairis_rainy-world.png;

  cursor = {
    name = "BreezeX-RosePineDawn-Linux";
    package = pkgs.rose-pine-cursor;
    size = 24;
  };

  icons = {
    name = "Papirus";
    package = (pkgs.catppuccin-papirus-folders.override {
      flavor = "macchiato";
      accent = "blue";
    });
  };

  # Default fonts
  serif = sansSerif;
  sansSerif = {
    package = pkgs.cantarell-fonts;
    name = "Cantarell";
  };
  monospace = {
    package = (pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ];});
    name = "SauceCodePro NFM";
  };
in
{
  home.packages = with pkgs; [
    wallust

    # Extra fonts
    # Sans serif
    noto-fonts-cjk-sans
    atkinson-hyperlegible
    raleway
    carlito

    # Serif
    noto-fonts-cjk-serif

    # Monospace
    courier-prime

    # Display / Handwriting
    (google-fonts.override {fonts = [
      "Limelight-Regular"
      "Oswald[wght]"
      "MajorMonoDisplay-Regular"
      "MaShanZheng-Regular"
    ]; })
    norwester-font
    lxgw-wenkai
  ] ++ [
    icons.package
    cursor.package
    sansSerif.package
    monospace.package
  ];

  stylix = {
    autoEnable = false;

    image = homescreen;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

    inherit cursor;

    fonts = {
      inherit serif;
      inherit sansSerif;
      inherit monospace;
      sizes.terminal = 14;
    };

    targets = {
      bat.enable = true;
      foot.enable = true;
      fzf.enable = true;
      yazi.enable = true;
      zathura.enable = true;
    };
  };

  gtk = {
    enable = true;
    font = sansSerif;
    iconTheme = icons;
    theme = {
      name = "rose-pine-moon";
      package = pkgs.rose-pine-gtk-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "breeze";
  };
}
