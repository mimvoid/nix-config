{
  imports = [ ./plugins.nix ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "yy";

    theme.status =
      let
        common = { open = ""; close = ""; };
      in
      {
        sep_left = common;
        sep_right = common;
      };

    settings = {
      mgr = {
        ratio = [ 1 4 3 ];
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
        max_width = 2000;
        max_height = 2000;
      };
    };
  };
}
