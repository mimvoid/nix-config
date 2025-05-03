{ pkgs, ... }:

{
  # Thunar additions
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };

  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };

  services.tumbler.enable = true;
}
