{
  programs.nixvim.plugins.telescope = {
    enable = true;

    settings.defaults = {
      mappings = {
        i = {
          "<A-j>".__raw = "require('telescope.actions').move_selection_next";
          "<A-k>".__raw = "require('telescope.actions').move_selection_previous";
        };
      };

      file_ignore_patterns = [
        "^.git/"
        "^.mypy_cache/"
        "^__pycache__/"
        "^output/"
        "^data/"
        "%.ipynb"
        ".sass-cache/*"
      ];

      vimgrep_arguments = [
        "rg"
        "--color=never"
        "--no-heading"
        "--with-filename"
        "--line-number"
        "--column"
        "--smart-case"
        # Search hidden files
        "--hidden"
        # Don't search .git/
        "--glob"
        "!**/.git/*"
      ];

      # Layout
      layout_config = {
        horizontal = {
          prompt_position = "bottom";
          preview_width = 0.4;
        };
        width = 0.8;
        height = 0.85;

        # Many previews don't appear unless this value is very low
        preview_cutoff = 1;
      };

      # Titles
      prompt_title = "";
      results_title = "";
      dynamic_preview_title = true;

      # Misc
      previewer = true;
      path_display = [ "truncate" ];
    };
  };
}
