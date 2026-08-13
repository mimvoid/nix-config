{ pkgs, ... }:

{
  imports = [ ./plugins.nix ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "yy";

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

    theme = {
      flavor = {
        dark = "base16";
        light = "base16";
      };
      status = {
        sep_left = { open = ""; close = ""; };
        sep_right = { open = ""; close = ""; };
      };
    };

    flavors.base16 = pkgs.fetchFromGitHub {
      owner = "matt-dong-123";
      repo = "base16.yazi";
      rev = "ed793528890e2b37595c76b70c212ccfdc81d9ae";
      hash = "sha256-1WhixzYE1zsXg9o6T/YKWJgzfRZnzsmpiUIfi+j4H9Q=";
    };
  };
}
