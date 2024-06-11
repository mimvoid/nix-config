{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ffmpegthumbnailer
    poppler
    unar
  ];

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableZshIntegration = true;
    settings = {
      manager = {
        ratio = [1 4 3];
        show_hidden = true;
        show_symlink = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = true;
        linemode = "none";
      };
      preview = {
        tab_size = 2;
      };
    };
  };
}
