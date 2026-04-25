{ pkgs, ... }:

{
  # Thunar additions
  programs.thunar = {
    enable = true;
    plugins = [
      pkgs.xfce.thunar-archive-plugin
      pkgs.xfce.thunar-media-tags-plugin
    ];
  };

  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };

  services.tumbler.enable = true;
}
